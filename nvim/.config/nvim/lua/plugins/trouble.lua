vim.api.nvim_create_autocmd("BufRead", {
	callback = function(ev)
		if vim.bo[ev.buf].buftype == "quickfix" then
			vim.schedule(function()
				vim.cmd([[cclose]])
				vim.cmd([[Trouble qflist open]])
			end)
		end
	end,
})

return {
	"folke/trouble.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {},
}
