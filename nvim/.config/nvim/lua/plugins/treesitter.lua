return  {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require 'nvim-treesitter.configs'.setup {
      highlight = {
        enable = true,
        disable = {},
      },
      indent = {
        enable = true,
        disable = {},
      },
      ensure_installed = {
        "rust",
        "toml",
        "json",
        "yaml",
        "css",
        "html",
        "typescript",
        "lua",
        "dockerfile",
        "tsx",
        "sql",
        "go",
        "vue"
      },
      endwise = {
        enable = true,
      },
    }
  end
}
