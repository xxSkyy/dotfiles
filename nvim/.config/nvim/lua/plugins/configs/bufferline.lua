local close_func = function(bufnum)
  local bufdelete_avail, bufdelete = pcall(require, "bufdelete")
  if bufdelete_avail then
    bufdelete.bufdelete(bufnum, true)
  else
    vim.cmd.bdelete { args = { bufnum }, bang = true }
  end
end
require("bufferline").setup({
  options = {
    offsets = {
      { filetype = "NvimTree", text = "", padding = 1 },
      { filetype = "neo-tree", text = "", padding = 1 },
      { filetype = "Outline", text = "", padding = 1 },
    },
    -- mode = "tabs",
    buffer_close_icon = neovim.get_icon "BufferClose",
    modified_icon = neovim.get_icon "FileModified",
    close_icon = neovim.get_icon "NeovimClose",
    close_command = close_func,
    right_mouse_command = close_func,
    max_name_length = 14,
    max_prefix_length = 13,
    tab_size = 20,
    separator_style = "thin",
  },
})
