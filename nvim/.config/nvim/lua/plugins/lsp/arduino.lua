local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local conf = require("telescope.config").values
local arduino = require 'arduino'

local get_arduino_baud = function()
  return vim.g.arduino_serial_baud
end



local get_arduino_boards = function()
  local boards = {}
  local boards_data = vim.fn.json_decode(vim.fn.system('arduino-cli board listall --format json'))

  if boards_data == nil or boards_data['boards'] == nil then
    vim.notify("Error getting board list from arduino-cli")
    return
  end

  for _, board in pairs(boards_data['boards']) do
    local board_name = board['name']
    local board_fqbn = board['fqbn']

    if board_name == nil or board_fqbn == nil then
      goto continue
    end

    table.insert(boards, {
      board_name,
      board_fqbn,
    })

    if string.find(board_name, "Nano") ~= nil then
      table.insert(boards, {
        board_name .. " (Old bootloader)",
        board_fqbn .. ":cpu=atmega328old",
      })
    end

    ::continue::
  end

  return boards
end

local get_arduino_ports = function()
  local global_ports = vim.g.arduino_serial_port_globs
  local ports = {}

  for _, glob in pairs(global_ports) do
    print(glob)
    local found = vim.fn.glob(glob, true, true)
    for _, port in pairs(found) do
      table.insert(ports, port)
    end
  end

  return ports
end

local get_first_port = function()
  local ports = get_arduino_ports()

  return ports[0] or ports[1] or nil
end

local set_selected_board = function(board)
  vim.g.arduino_board = board
end

local set_selected_port = function(port)
  vim.g.arduino_serial_port = port
end

local get_arduino_port = function()
  local global_port = vim.g.arduino_serial_port
  if global_port ~= nil then
    return global_port
  else
    return get_first_port()
  end
end

local open_arduino_serial = function(log)
  local baud = get_arduino_baud()
  local port = get_arduino_port()

  local params = ""

  if log then
    params = params .. " -L"
  end

  if port == nil then
    vim.notify("Can't find arduino port.")
    return
  end

  vim.cmd("5TermExec direction=float cmd='screen " .. params .. " " .. port .. " " .. baud .. "'")
end

local kill_arduino_serial = function()
  local baud = get_arduino_baud() or 9600
  local port = get_arduino_port()

  os.execute("pkill -f " .. port .. "  " .. baud)
end

vim.api.nvim_create_user_command("ArduinoSerialKill",
  function()
    kill_arduino_serial()
  end,
  {})

local select_board = function()
  local list = get_arduino_boards()

  if list == nil then
    return
  end

  pickers.new({}, {
    prompt_title = "Select active board",
    finder = finders.new_table({
      results = list,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry[1],
          ordinal = entry[1],
        }
      end,
    }),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)

        local selection = action_state.get_selected_entry()
        local selected_board_name = selection.value[1]
        local selected_board = selection.value[2]

        set_selected_board(selected_board)
        vim.notify("Set selected board to: " .. selected_board_name .. " (" .. selected_board .. ")")
      end)
      return true
    end,
    sorter = conf.generic_sorter({}),
  }):find();
end

local select_serial = function()
  local list = get_arduino_ports()

  pickers.new({}, {
    prompt_title = "Select active serial",
    finder = finders.new_table(list),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)

        local selection = action_state.get_selected_entry()
        local selected_board = selection.value

        set_selected_port(selected_board)
        vim.notify("Set selected serial to: " .. selected_board)
      end)
      return true
    end,
    sorter = conf.generic_sorter({}),
  }):find();
end

local fqbn = "arduino:avr:nano:cpu=atmega328old"
-- local clangd = require 'mason-core.path'.bin_prefix 'clangd'


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.didChange = nil
capabilities.workspace.semanticTokens = nil

require 'lspconfig'.arduino_language_server.setup {
  cmd = {
    "arduino-language-server",
    "--clangd", "/usr/bin/clangd",
    "--cli-config", "~.config/arduino/arduino-cli.yaml",
    "--fqbn", fqbn
  },
  capabilities = capabilities,
  on_attach = function(_, bufnr)
    set_selected_board("arduino:avr:nano:cpu=atmega328old")

    local maps = neovim.get_clean_mappings()

    local prefix = "A"

    maps.n[prefix .. "u"] = { "<cmd>ArduinoSerialKill<cr><cmd>arduinoupload<cr>", desc = "Arduino upload" }
    maps.n[prefix .. "k"] = {
      function()
        kill_arduino_serial()
        vim.notify("Killed arduino serial!")
      end,
      desc = "Kill arduino serial logger"
    }
    maps.n[prefix .. "L"] = {
      function()
        open_arduino_serial(true)
      end,
      desc = "Arduino serial logger with logging to file"
    }
    maps.n[prefix .. "l"] = {
      open_arduino_serial,
      desc = "Arduino serial logger"
    }
    maps.n[prefix .. "v"] = { "<cmd>ArduinoVerify<cr>", desc = "Arduino verify" }
    maps.n[prefix .. "s"] = { select_serial, desc = "Arduino choose serial" }
    maps.n[prefix .. "b"] = { select_board, desc = "Arduino choose board" }

    -- Disable mappings, switched to PIO
    -- neovim.set_mappings(maps)


    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end
}
