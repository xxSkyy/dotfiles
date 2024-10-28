return {
  "imNel/monorepo.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"
  },
  config = function()
    neovim.require("monorepo", { autoload_telescope = false })
  end
}
