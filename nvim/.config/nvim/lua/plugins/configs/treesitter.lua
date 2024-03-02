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
  autotag = {
    enable = true,
    enable_close_on_slash = false,
    filetypes = {
      'html',
      'javascript',
      'typescript',
      'javascriptreact',
      'typescriptreact',
      'svelte',
      'vue',
      'tsx',
      'jsx',
      'rescript',
      'xml',
      'php',
      'markdown',
      'glimmer',
      'handlebars',
      'hbs',
      'rust',
      'go',
    }
  },
}
