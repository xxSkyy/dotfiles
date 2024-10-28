return {
 -- Lazygit wrapper for neovim 
  {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  -- Shows git decorations
  {
    'lewis6991/gitsigns.nvim',
    config = function() neovim.require('gitsigns') end
  },
}
