local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local conf = require("telescope.config").values

local workspace_uuid = neovim.generate_uuid()

local root_patterns = { "platformio.ini" }
local matcher = require 'lspconfig'.util.root_pattern(root_patterns)

local isPioDir = matcher(vim.fn.getcwd())

if (isPioDir == nil) then
  return
end

local bauds_list = {
  "500000",
  "250000",
  "115200",
  "19200",
  "9600",
}

local get_bauds = function()
  return bauds_list
end

local arduino_serial_port_globs = {
  "/dev/ttyACM*",
  "/dev/ttyUSB*",
  "/dev/tty.usbmodem*",
  "/dev/tty.usbserial*",
  "/dev/tty.wchusbserial*",
  "/dev/cu.usbmodem*",
  "/dev/cu.PL2303*"
}

local selected_device = nil
local selected_env = nil
local selected_baud = 9600


local set_env = function(env)
  selected_env = env
end

local set_device = function(device)
  selected_device = device
end

local deselect_device = function()
  set_device(nil)
  vim.notify("Deselected device")
end

local deselect_env = function()
  set_env(nil)
  vim.notify("Deselected env")
end

local get_env = function()
  return selected_env
end

local get_baud = function()
  return selected_baud
end

local get_device = function()
  return selected_device
end

local set_baud = function(baud)
  selected_baud = baud
end


local defaultNoneString = function(str)
  if (str == nil) then
    return '--'
  end

  return str
end

local show_info = function()
  local info = "PIO workspace info: \nSelected: device: " ..
      defaultNoneString(selected_device) .. "\nSelected env: " .. defaultNoneString(selected_env)

  vim.notify(info)
end

local get_pio_envs = function()
  local envs      = {}
  local envs_data = vim.fn.json_decode(vim.fn.system('pio project config --json-output '))

  if envs_data == nil then
    vim.notify("Error getting board list from pio")
    return
  end


  for _, env in pairs(envs_data) do
    local env_string = env[1]:gsub("env:", "")
    table.insert(envs, env_string)
  end

  return envs
end

local get_arduino_devices = function()
  local boards = {}
  local boards_data = vim.fn.json_decode(vim.fn.system('pio device list --json-output'))

  if boards_data == nil then
    vim.notify("Error getting board list from pio")
    return
  end


  for _, board in pairs(boards_data) do
    if (string.find(board.port, "usbserial") or string.find(board.port, "PL2303") or string.find(board.port, "usbmodem")) then
      table.insert(boards, board.port)
    end
  end

  return boards
end


local select_baud = function()
  local bauds = get_bauds()

  pickers.new({}, {
    prompt_title = "Select monitor baudrate",
    finder = finders.new_table(bauds),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)

        local selection = action_state.get_selected_entry()
        local baud = selection.value

        set_baud(baud)
        vim.notify("Set baud to: " .. baud)
      end)
      return true
    end,
    sorter = conf.generic_sorter({}),
  }):find();
end

local select_env = function()
  local envs = get_pio_envs()

  pickers.new({}, {
    prompt_title = "Select active env",
    finder = finders.new_table(envs),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)

        local selection = action_state.get_selected_entry()
        local env = selection.value

        set_env(env)
        vim.notify("Set selected env to: " .. env)
      end)
      return true
    end,
    sorter = conf.generic_sorter({}),
  }):find();
end


local open_monitor = function()
  local baud = get_baud()
  local device = get_device()

  local params = " -b " .. baud

  if device then
    params = params .. " -p " .. device .. " "
  end

  vim.cmd("5TermExec direction=float cmd='UUID=" ..
    workspace_uuid .. " pio device monitor " .. params .. " --filter colorize'")
end

local kill_monitor = function()
  os.execute("pkill -f " .. workspace_uuid .. "  monitor")
end

local upload = function()
  local device = get_device()
  local env = get_env()
  local baud = get_baud()

  local params = " --monitor-port " .. baud

  if device then
    params = params .. " --upload-port " .. device .. " "
  end

  if env then
    params = params .. " -e " .. env .. " "
  end

  vim.cmd("6TermExec direction=float cmd='\rclear\rUUID=" .. workspace_uuid .. " pio run -t upload " .. params .. "'")
end

local verify = function()
  vim.cmd("7TermExec direction=float cmd='\rclear\rpio run'")
end

local select_device = function()
  local list = get_arduino_devices()

  pickers.new({}, {
    prompt_title = "Select active device",
    finder = finders.new_table(list),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)

        local selection = action_state.get_selected_entry()
        local selected_board = selection.value


        set_device(selected_board)
        vim.notify("Set selected serial to: " .. selected_board)
      end)
      return true
    end,
    sorter = conf.generic_sorter({}),
  }):find();
end

local add_library = function()
  local library = vim.fn.input("Library name or url: ", "")

  if (library == nil or library == "") then return end

  vim.cmd("8TermExec direction=float cmd='\rclear\rUUID=" .. workspace_uuid .. " pio pkg install -l  " .. library .. "'")
end

local compile = function()
  vim.fn.system("pio run -t compiledb")
  vim.notify("Compiledb executed")
end

-- Platformio has issue with clangd and esp32. Compiling only
-- under arduino solves the issue. Temporary fix.
local safe_compile = function()
  vim.fn.system("pio run -t compiledb -e nanoatmega328")
  vim.notify("[Safe mode] Compiledb executed")
end


local maps = neovim.get_clean_mappings()
local prefix = "A"

maps.n[prefix .. "s"] = { select_device, desc = "[PIO] Select serial" }
maps.n[prefix .. "S"] = { deselect_device, desc = "[PIO] Deselect serial" }
maps.n[prefix .. "e"] = { select_env, desc = "[PIO] Select env" }
maps.n[prefix .. "E"] = { deselect_env, desc = "[PIO] Deselect env" }
maps.n[prefix .. "i"] = { show_info, desc = "[PIO] Show info" }
maps.n[prefix .. "v"] = { verify, desc = "[PIO] Open monitor" }
maps.n[prefix .. "m"] = { open_monitor, desc = "[PIO] Open monitor" }
maps.n[prefix .. "l"] = { add_library, desc = "[PIO] Add library" }
maps.n[prefix .. "c"] = { compile, desc = "[PIO] Compiledb" }
maps.n[prefix .. "C"] = { safe_compile, desc = "[PIO] Compiledb (Safe)" }
maps.n[prefix .. "M"] = {
  function()
    kill_monitor()
    open_monitor()
  end,
  desc = "[PIO] Restart and open monitor"
}
maps.n[prefix .. "k"] = {
  function()
    kill_monitor()
    vim.notify("Killed monitor!")
  end,
  desc = "[PIO] Kill monitor"
}
maps.n[prefix .. "b"] = { select_baud, desc = "[PIO] Select baud" }
maps.n[prefix .. "u"] = {
  function()
    kill_monitor()
    upload()
  end,
  desc = "[PIO] Upload"
}

neovim.set_mappings(maps)
