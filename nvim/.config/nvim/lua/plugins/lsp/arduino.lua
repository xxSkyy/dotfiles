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

local get_artuino_port = function()
  local global_port = vim.g.arduino_serial_port
  if global_port ~= nil then
    return global_port
  else
    return get_first_port()
  end
end

local open_arduino_serial = function()
  local baud = get_arduino_baud()
  local port = get_artuino_port()

  if port == nil then
    vim.notify("Can't find arduino port.")
    return
  end

  vim.cmd("5TermExec direction=float cmd='screen " .. port .. " " .. baud .. "'")
end

local kill_arduino_serial = function()
  local baud = get_arduino_baud() or 9600
  os.execute("pkill -f tty " .. baud)
end


vim.api.nvim_create_user_command("ArduinoSerialKill",
  function()
    kill_arduino_serial()
  end,
  {})

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
      function()
        open_arduino_serial()
      end,
      desc = "Arduino serial"
    }
    maps.n["<C-a>v"] = { "<cmd>ArduinoVerify<cr>", desc = "Arduino verify" }
    maps.n["<C-a>b"] = { "<cmd>ArduinoChooseBoard<cr>", desc = "Arduino choose board" }

    neovim.set_mappings(maps)
  end
}
