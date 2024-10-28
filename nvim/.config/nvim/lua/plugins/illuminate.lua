-- Show matching words
return {
	"RRethy/vim-illuminate",
	config = function()
		require("illuminate").configure({
			modes_denylist = { "v" },
			providers = {
				"lsp",
				-- 'treesitter',
				"regex",
			},
		})
	end,
}
