-- Multiple terminals, floating etc
return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {
		size = 10,
		-- open_mapping = [[<F7>]],
		persist_mode = false,
		shading_factor = 2,
		direction = "horizontal",
		float_opts = {
			border = "curved",
			highlights = {
				border = "Normal",
				background = "Normal",
			},
		},
	},
}
