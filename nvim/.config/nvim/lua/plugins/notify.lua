-- Fancy notifications
return {
  'rcarriga/nvim-notify',
  opts = {
    background_colour = "#000000",
    timeout = 3000,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.60)
    end,
    on_open = function(win)
      vim.api.nvim_win_set_config(win, { focusable = false })
    end,
    render = "default",
    stages = "fade_in_slide_out",
  },
}
