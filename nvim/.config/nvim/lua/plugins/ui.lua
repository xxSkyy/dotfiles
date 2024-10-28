return {
	-- Better UI
	{
		"folke/noice.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
	},

	-- LSP loading progress
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		opts = {
			window = {
				blend = 0,
				zindex = 1,
			},
		},
	},

	{ "davidosomething/format-ts-errors.nvim" },
	{
		"OlegGulevskyy/better-ts-errors.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		config = {
			keymaps = {
				toggle = "<leader>dd", -- default '<leader>dd'
				go_to_definition = "<leader>dx", -- default '<leader>dx'
			},
		},
	},

	-- Lsp lines errors, turn off by default
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()
			require("lsp_lines").toggle()
		end,
	},

	-- Pretty hover
	{
		"Fildo7525/pretty_hover",
		event = "LspAttach",
		opts = {},
	},
	{
		"stevearc/dressing.nvim",
		opts = {},
	},
}
