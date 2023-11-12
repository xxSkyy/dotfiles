require 'lspconfig'.sourcekit.setup {
  capabilities = neovim.capabilities
}


require 'lspconfig'.clangd.setup {
  capabilities = neovim.capabilities,
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  },
}
