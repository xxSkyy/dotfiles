require("lspconfig").volar.setup({
	capabilities = neovim.capabilities,
	documentFeatures = {
		documentFormatting = {
			defaultPrintWidth = 60,
		},
	},
	settings = {
		typescript = {
			preferences = {
				-- "relative" | "non-relative" | "auto" | "shortest"(not sure)
				importModuleSpecifier = "non-relative",
			},
		},
	},
})
