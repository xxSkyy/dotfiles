local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local conf = require("telescope.config").values
local arduino = require 'arduino'

local get_arduino_baud = function()
  return vim.g.arduino_serial_baud
end

local get_arduino_ports = function()
  local global_ports = vim.g.arduino_serial_port_globs
  local ports = {}

  for _, glob in pairs(global_ports) do
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

local open_arduino_serial = function()
  local baud = get_arduino_baud()
  local port = get_arduino_port()

  if port == nil then
    vim.notify("Can't find arduino port.")
    return
  end

  vim.cmd("5TermExec direction=float cmd='screen " .. port .. " " .. baud .. "'")
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


local select_serial = function()
  local list = get_arduino_ports()

  pickers.new({}, {
    prompt_title = "Select board",
    finder = finders.new_table(list),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)

        local selection = action_state.get_selected_entry()
        local selected_board = selection.value

        set_selected_port(selected_board)
        vim.notify("Set selected board to: " .. selected_board)
      end)
      return true
    end,
    sorter = conf.generic_sorter({}),
  }):find();
end

require 'lspconfig'['arduino_language_server'].setup {
  on_new_config = arduino.on_new_config,
  on_attach = function()
    local maps = neovim.get_clean_mappings()

    maps.n["<C-a>u"] = { "<cmd>ArduinoSerialKill<cr><cmd>ArduinoUpload<cr>", desc = "Arduino upload" }
    maps.n["<C-a>k"] = {
      function()
        kill_arduino_serial()
        vim.notify("Killed arduino serial!")
      end,
      desc = "Kill arduino serial"
    }
    maps.n["<C-a>S"] = {
      function()
        kill_arduino_serial()
        open_arduino_serial()
      end,
      desc = "Arduino serial (kill previous one)"
    }
    maps.n["<C-a>s"] = {
      open_arduino_serial,
      desc = "Arduino serial"
    }
    maps.n["<C-a>v"] = { "<cmd>ArduinoVerify<cr>", desc = "Arduino verify" }
    maps.n["<C-a>b"] = { select_serial, desc = "Arduino choose board" }

    neovim.set_mappings(maps)
  end
}
