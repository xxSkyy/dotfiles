-- Database
return {
	"tpope/vim-dadbod",
	lazy = true,

	dependencies = {
		"kristijanhusak/vim-dadbod-ui",
		"kristijanhusak/vim-dadbod-completion",
	},

	config = function()
		vim.g.db_ui_save_location = vim.fn.stdpath("config") .. require("plenary.path").path.sep .. "db_ui"

		-- vim.api.nvim_create_autocmd("FileType", {
		--   pattern = {
		--     "sql",
		--   },
		--   command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
		-- })

		vim.api.nvim_create_autocmd("FileType", { pattern = { "sql", "mysql", "plsql" } })
	end,

	cmd = {
		"DBUIToggle",
		"DBUI",
		"DBUIAddConnection",
		"DBUIFindBuffer",
		"DBUIRenameBuffer",
		"DBUILastQueryInfo",
	},
}
