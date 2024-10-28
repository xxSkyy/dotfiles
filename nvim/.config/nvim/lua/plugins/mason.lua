return {
	-- LSP UI Installer
	{
		"williamboman/mason.nvim",
		opts = {},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"denols",
				"rust_analyzer",
				"jsonls",
				"volar",
				"ts_ls",
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
		},
	},
}
