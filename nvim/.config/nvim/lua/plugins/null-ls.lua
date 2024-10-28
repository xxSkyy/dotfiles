return {
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.prettier,
					-- null_ls.builtins.formatting.rustfmt,
					null_ls.builtins.formatting.gofmt,
					null_ls.builtins.completion.luasnip,
					null_ls.builtins.formatting.astyle,
					-- null_ls.builtins.completion.spell,
				},
			})
		end,
	},

	{
		"jayp0521/mason-null-ls.nvim",
		opts = {},
	},
}
