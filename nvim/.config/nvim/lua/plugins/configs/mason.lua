neovim.require('mason')

neovim.require('mason-lspconfig', {
  ensure_installed = {
    "denols",
    "rust_analyzer",
    "jsonls",
    "volar",
    "tsserver",
    "tailwindcss",
    "sqlls",
    "graphql",
    "dockerls",
    "cssls",
    "gopls",
    "jdtls",
    "clangd",
    "html",
    "prismals",
    "bashls",
    "lua_ls",
    "cssls",
  },
})
