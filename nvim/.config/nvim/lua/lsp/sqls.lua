require("lspconfig").sqlls.setup({
	capabilities = neovim.capabilities,
	on_attach = function(client, bufnr)
		require("sqls").on_attach(client, bufnr)
	end,
})
