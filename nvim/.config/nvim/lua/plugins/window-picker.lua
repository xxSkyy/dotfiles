return {
	"s1n7ax/nvim-window-picker",
	event = "VeryLazy",
	version = "v2.*",
	show_prompt = true,
	opts = {
		hint = "floating-big-letter",
		show_prompt = false,
		autoselect_one = true,
		include_current = false,
		filter_rules = {
			-- filter using buffer options
			bo = {
				-- if the file type is one of following, the window will be ignored
				filetype = { "neo-tree", "neo-tree-popup", "notify" },
				-- if the buffer type is one of following, the window will be ignored
				buftype = { "terminal", "quickfix" },
			},
		},
		other_win_hl_color = "#e35e4f",
	},
}
