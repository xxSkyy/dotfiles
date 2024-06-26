local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local conf = require("telescope.config").values

local workspace_uuid = neovim.generate_uuid()

local root_patterns = { "sdkconfig", "CMakeLists.txt" }
local matcher = require 'lspconfig'.util.root_pattern(root_patterns)

local isIdfDir = matcher(vim.fn.getcwd())

if (isIdfDir == nil) then
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
local selected_baud = 115200


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

local run_cmd = function(task, params, terminal_id, init_idf)
  if init_idf == nil then init_idf = true end

  -- Ensure the path to esp-idf export.sh
  local idf_init_sh = ""
  if init_idf then
    idf_init_sh = "if [ -z $IDF_PATH ]; then get_idf; fi;"
  end


  local cmd = string.format(
    "UUID=%s %s %s'",
    workspace_uuid,
    task,
    params
  )

  -- Execute the command in a floating terminal
  vim.cmd(terminal_id .. "TermExec direction=float cmd='" .. idf_init_sh .. "clear;" .. cmd .. "'")
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

local add_device_to_params = function(params)
  local device = get_device()

  if device then
    params = params .. " -p " .. device .. " "
  end

  return params
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


local get_serial_devices = function()
  local boards = {}

  -- Run the 'ls /dev/' command and capture its output
  local result = vim.fn.system('ls /dev/')

  if result == nil then
    vim.notify("Error listing devices")
    return
  end

  -- Split the output into lines
  local devices = vim.fn.split(result, "\n")

  -- Filter the devices
  for _, device in ipairs(devices) do
    if (string.find(device, "ttyUSB") or string.find(device, "ttyS") or string.find(device, "ttyACM") or string.find(device, "cu.usbserial") or string.find(device, "cu.PL2303") or string.find(device, "cu.usbmodem") or string.find(device, "cu.wch")) then
      table.insert(boards, "/dev/" .. device)
    end
  end

  return boards
end

-- Example usage


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

  local params = " -b " .. baud

  params = add_device_to_params(params)

  run_cmd("idf.py monitor", params, 5)
end

local kill_monitor = function()
  os.execute("pkill -f " .. workspace_uuid .. "  monitor")
end

local upload_fs = function()
  local env = get_env()
  local baud = get_baud()

  local params = " --monitor-port " .. baud

  params = add_device_to_params(params)

  if env then
    params = params .. " -e " .. env .. " "
  end

  vim.cmd("6TermExec direction=float cmd='\rclear\rUUID=" ..
    workspace_uuid .. " pio run -t uploadfs " .. params .. "'")
end


local kill_simulator = function()
  os.execute("pkill -f " .. workspace_uuid .. "  /bin/main")
end

local run_simulator = function()
  local cwd = vim.fn.getcwd()


  local cmd = string.format(
    "UUID=%s cd %s/build/ ; make -j ; cd %s ; ./bin/main'",
    workspace_uuid,
    cwd,
    cwd
  )


  kill_simulator()
  run_cmd(cmd, "", 6, false)
end


local upload = function()
  local env = get_env()

  local params = ""

  params = add_device_to_params(params)

  if env then
    params = params .. " -e " .. env .. " "
  end

  run_cmd("idf.py flash", params, 6)
end

local compile = function()
  run_cmd("idf.py build", "", 6)
end

local menu_config = function()
  run_cmd("idf.py menuconfig", "", 7)
end

local select_device = function()
  local list = get_serial_devices()

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

-- Hard-coded list of targets
local esp_targets = {
  "esp32",
  "esp32s2",
  "esp32c3",
  "esp32s3",
  "esp32c2",
  "esp32c6",
  "esp32h2"
}

local select_target = function()
  pickers.new({}, {
    prompt_title = "Select ESP-IDF Target",
    finder = finders.new_table(esp_targets),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)

        local selection = action_state.get_selected_entry()
        local target = selection.value

        -- Run idf.py set-target with the selected target
        run_cmd("idf.py set-target ", target, 9)
        vim.notify("Target set to: " .. target)
      end)
      return true
    end,
    sorter = conf.generic_sorter({}),
  }):find();
end

local add_library = function()
  local library = vim.fn.input("Library name or url: ", "")

  if (library == nil or library == "") then return end

  run_cmd("idf.py add-dependency ", library, 7)
end

local maps = neovim.get_clean_mappings()
local prefix = "A"

maps.n[prefix .. "s"] = { select_device, desc = "[IDF] Select serial" }
maps.n[prefix .. "S"] = { deselect_device, desc = "[IDF] Deselect serial" }
maps.n[prefix .. "e"] = { select_env, desc = "[IDF] Select env" }
maps.n[prefix .. "E"] = { deselect_env, desc = "[IDF] Deselect env" }
maps.n[prefix .. "i"] = { show_info, desc = "[IDF] Show info" }
maps.n[prefix .. "m"] = { open_monitor, desc = "[IDF] Open monitor" }
maps.n[prefix .. "l"] = { add_library, desc = "[IDF] Add library" }
maps.n[prefix .. "c"] = { compile, desc = "[IDF] Compile" }
maps.n[prefix .. "C"] = { menu_config, desc = "[IDF] Menu config" }
maps.n[prefix .. "t"] = { select_target, desc = "[IDF] Select target" }
maps.n[prefix .. "r"] = { run_simulator, desc = "[LVGL] Run simulator" }
maps.n[prefix .. "R"] = { kill_simulator, desc = "[LVGL] Kill simulator" }
maps.n[prefix .. "M"] = {
  function()
    kill_monitor()
    open_monitor()
  end,
  desc = "[IDF] Restart and open monitor"
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
maps.n[prefix .. "f"] = {
  function()
    kill_monitor()
    upload_fs()
  end,
  desc = "[PIO] UploadFS"
}

neovim.set_mappings(maps)
