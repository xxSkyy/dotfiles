local capabilities = neovim.capabilities
capabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").cssls.setup({
	capabilities = capabilities,
})
