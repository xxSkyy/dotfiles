local close_func = function(bufnum)
	local bufdelete_avail, bufdelete = pcall(require, "bufdelete")
	if bufdelete_avail then
		bufdelete.bufdelete(bufnum, true)
	else
		vim.cmd.bdelete({ args = { bufnum }, bang = true })
	end
end

-- Everything related do buffers
return {
	-- Tabs
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				offsets = {
					{ filetype = "NvimTree", text = "", padding = 1 },
					{ filetype = "neo-tree", text = "", padding = 1 },
					{ filetype = "Outline", text = "", padding = 1 },
				},
				-- mode = "tabs",
				buffer_close_icon = neovim.get_icon("BufferClose"),
				modified_icon = neovim.get_icon("FileModified"),
				close_icon = neovim.get_icon("NeovimClose"),
				close_command = close_func,
				right_mouse_command = close_func,
				max_name_length = 14,
				max_prefix_length = 13,
				tab_size = 20,
				separator_style = "thin",
			},
		},
	},

	-- Close current buffer
	{
		"kazhala/close-buffers.nvim",
		config = function()
			neovim.require("close_buffers", {
				preserve_window_layout = { "this" },
				next_buffer_cmd = function(windows)
					require("bufferline").cycle(1)
					local bufnr = vim.api.nvim_get_current_buf()

					for _, window in ipairs(windows) do
						vim.api.nvim_win_set_buf(window, bufnr)
					end
				end,
			})
		end,
	},
}
