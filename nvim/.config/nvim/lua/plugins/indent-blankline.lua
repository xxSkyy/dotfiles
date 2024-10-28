return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {},
	config = function()
		local highlight = {
			"OchreYellow",
			"WaveBlue",
			"PeachRed",
			"SpringGreen",
			"LightViolet",
			"Teal",
			"AutumnRed",
		}

		local hooks = require("ibl.hooks")

		-- Create the highlight groups in the highlight setup hook, so they are reset
		-- every time the colorscheme changes
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "AutumnRed", { fg = "#621E21" }) -- Dimmed AutumnRed
			vim.api.nvim_set_hl(0, "OchreYellow", { fg = "#6E522F" }) -- Dimmed OchreYellow
			vim.api.nvim_set_hl(0, "WaveBlue", { fg = "#3F5A65" }) -- Dimmed WaveBlue
			vim.api.nvim_set_hl(0, "PeachRed", { fg = "#80501D" }) -- Dimmed PeachRed
			vim.api.nvim_set_hl(0, "SpringGreen", { fg = "#3B4A35" }) -- Dimmed SpringGreen
			vim.api.nvim_set_hl(0, "LightViolet", { fg = "#4B3D5C" }) -- Dimmed LightViolet
			vim.api.nvim_set_hl(0, "Teal", { fg = "#3D5450" }) -- Dimmed Teal
		end)

		require("ibl").setup({ indent = { highlight = highlight } })
	end,
}
