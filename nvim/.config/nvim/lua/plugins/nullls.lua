return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }
  },

  {
    "jayp0521/mason-null-ls.nvim",
    config = function() neovim.require('mason-null-ls') end
  },
}
