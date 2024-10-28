return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"marilari88/neotest-vitest",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"haydenmeade/neotest-jest",
		"rouge8/neotest-rust",
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-vitest"),
					require("neotest-jest"),
					require("neotest-rust"),
				},
				on_attach = function()
					-- TODO: Mappings on <leader>e..
				end,
			})
		end,
	},
}
