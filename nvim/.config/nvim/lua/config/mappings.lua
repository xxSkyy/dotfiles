local maps = neovim.get_clean_mappings()

maps[""]["<Space>"] = "<Nop>"

maps.i = { ["jk"] = { "" }, ["<S-Tab>"] = { "<C-d>" } }

maps.n = {
	-- Disable arrows
	["<Up>"] = { "<Nop>" },
	["<Down>"] = { "<Nop>" },
	["<Left>"] = { "<Nop>" },
	["<Right>"] = { "<Nop>" },
	["<C-d>"] = { "<C-d>zz" },
	["<C-u>"] = { "<C-u>zz" },

	["n"] = { "nzzzv" },
	["N"] = { "Nzzzv" },
}

-- Pasting yanked not deleted n' yanked value
maps.n[",p"] = { '"0p' }
maps.n[",P"] = { '"0P' }
maps.v["<leader>p"] = { '"_dP', desc = "Paste on selection without yank" }

-- Clipboard mappings
maps.n["C"] = { "<Nop>" }
maps.n["Cy"] = { '"+y', desc = "Copy to system clipboard" }
maps.n["CY"] = { '"+Y', desc = "Copy line to system clipboard (Y)" }
maps.n["Cd"] = { '"+d', desc = "Delete to system clipboard" }
maps.n["CD"] = { '"+D', desc = "Delete to end of line to system clipboard" }
maps.n["Cc"] = { '"+c', desc = "Change with system clipboard" }
maps.n["CC"] = { '"+C', desc = "Change to end of line with system clipboard" }
maps.n["Cp"] = { '"+p', desc = "Paste from system clipboard" }

maps.v["C"] = { "<Nop>" }
maps.v["Cy"] = { '"+y', desc = "Copy selection to system clipboard" }
maps.v["CY"] = { '"+Y', desc = "Copy line selection to system clipboard" }
maps.v["Cd"] = { '"+d', desc = "Delete selection to system clipboard" }
maps.v["CD"] = { '"+D', desc = "Delete full line selection to system clipboard" }
maps.v["Cc"] = { '"+c', desc = "Change selection with system clipboard" }
maps.v["Cp"] = { '"+p', desc = "Paste from system clipboard" }

-- Nvim clipboard mappings (separation from system clipboard)
maps.n["y"] = { '"1y', desc = "Copy" }
maps.n["Y"] = { '"1Y', desc = "Copy line (Y)" }
maps.n["d"] = { '"1d', desc = "Delete" }
maps.n["D"] = { '"1D', desc = "Delete to end of line" }
maps.n["c"] = { '"1c', desc = "Change" }
maps.n["p"] = { '"1p', desc = "Paste" }

maps.v["y"] = { '"1y', desc = "Copy selection " }
maps.v["Y"] = { '"1Y', desc = "Copy line selection " }
maps.v["d"] = { '"1d', desc = "Delete selection " }
maps.v["D"] = { '"1D', desc = "Delete full line selection " }
maps.v["c"] = { '"1c', desc = "Change selection" }
maps.v["p"] = { '"1p', desc = "Paste" }

-- Normal --
-- Standard Operations
maps.n["<leader>fn"] = { "<cmd>enew<cr>", desc = "New File" }
-- maps.n["gx"] = { function() neovim.system_open() end, desc = "Open the file under cursor with system app" }
maps.n["Q"] = "<Nop>"

-- CodeAction Menu
maps.n["<leader>a"] = { "<cmd>CodeActionMenu<cr>", desc = "Code action menu" }

-- Trouble
maps.n["<leader>xl"] = {
	"<cmd>Trouble lsp toggle<cr>",
	desc = "Trouble workspace window",
}
maps.n["<leader>xd"] = {
	"<cmd>Trouble diagnostics toggle<cr>",
	desc = "Trouble document window",
}
maps.n["<leader>xq"] = {
	"<cmd>Trouble qflist toggle<cr>",
	desc = "Trouble quickfix window",
}
maps.n["<leader>xl"] = {
	"<cmd>Trouble lsp toggle<cr>",
	desc = "Trouble loclist window",
}

-- LSP
maps.n["<leader>ld"] = { vim.lsp.buf.declaration, desc = "LSP Declaration" }
maps.n["<leader>lt"] = {
	vim.lsp.buf.type_definition,
	desc = "LSP Type definition",
}
maps.n["<leader>ls"] = {
	vim.lsp.buf.signature_help,
	desc = "LSP Signature help",
}
maps.n["<leader>li"] = {
	vim.lsp.buf.implementation,
	desc = "LSP Implementation",
}
maps.n["<leader>lr"] = { vim.lsp.buf.references, desc = "LSP References" }
maps.n["<leader>lG"] = {
	function()
		require("telescope.builtin").lsp_workspace_symbols()
	end,
	desc = "Telescope Search workspace symbols",
}
maps.n["<leader>lR"] = {
	function()
		require("telescope.builtin").lsp_references()
	end,
	desc = "Telescope LSP references",
}
maps.n["<leader>lD"] = {
	function()
		require("telescope.builtin").diagnostics()
	end,
	desc = "Telescope Search diagnostics",
}
maps.n["<leader>lI"] = {
	function()
		require("telescope.builtin").lsp_implementations()
	end,
	desc = "Telescope LSP Implementation",
}

-- Navigate buffers
maps.n["<S-l>"] = { "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer tab" }
maps.n["<S-h>"] = {
	"<cmd>BufferLineCyclePrev<cr>",
	desc = "Previous buffer tab",
}
maps.n[">b"] = {
	"<cmd>BufferLineMoveNext<cr>",
	desc = "Move buffer tab right",
}
maps.n["<b"] = {
	"<cmd>BufferLineMovePrev<cr>",
	desc = "Move buffer tab left",
}

-- Lsp lines
maps.n["<leader>L"] = {
	function()
		require("lsp_lines").toggle()
	end,
	desc = "Toggle LSP lines",
}

-- Close current buffer
maps.n["<leader>cc"] = {
	"<cmd>lua require('close_buffers').delete({type = 'this'})<CR>",
	noremap = true,
	desc = "Close current buffer",
}
maps.n["<leader>cC"] = {
	"<cmd>lua require('close_buffers').delete({type = 'this', force = true})<CR>",
	noremap = true,
	desc = "Force close current buffer",
}
maps.n["<leader>cr"] = {
	"<cmd>BufferLineCloseRight<CR>",
	noremap = true,
	desc = "Close close all buffers to right",
}
maps.n["<leader>cl"] = {
	"<cmd>BufferLineCloseLeft<CR>",
	noremap = true,
	desc = "Close all buffers to left",
}
maps.n["<leader>ca"] = {
	"<cmd>BufferLineCloseLeft<CR><cmd>BufferLineCloseRight<CR>",
	noremap = true,
	desc = "Close all buffers but active one",
}
maps.n["<leader>cA"] = {
	"<cmd>BufferLineCloseLeft<CR><cmd>BufferLineCloseRight<CR><cmd>lua require('close_buffers').delete({type = 'this'})<CR>",
	noremap = true,
	desc = "Close all buffers with active one",
}

-- Dapui
maps.n["<leader>bt"] = {
	function()
		require("dapui").toggle()
	end,
	desc = "DapUI Toggle",
}
-- maps.n["<leader>be"] = { function() require("dapui").() end, desc = "DapUI Edit expression" }
maps.n["<leader>bb"] = {
	"<cmd>lua require'dap'.toggle_breakpoint()<cr>",
	desc = "Toggle breakpoint",
}
maps.n["<leader>bB"] = {
	"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
	desc = "Toggle breakpoint",
}
maps.n["<leader>bx"] = {
	"<cmd>lua require'dap'.clear_breakpoints()<cr>",
	desc = "Clear breakpoints",
}
maps.n["<leader>bc"] = {
	"<cmd>lua require'dap'.continue()<cr>",
	desc = "Continue executing debugger",
}
maps.n["<leader>bs"] = {
	"<cmd>lua require'dap'.step_over()<cr>",
	desc = "Step through code",
}
maps.n["<leader>bi"] = {
	"<cmd>lua require'dap'.repl.open()<cr>",
	desc = "Inspect state",
}
maps.n["<leader>bl"] = {
	"<cmd>lua require'dap'.run_last()<cr>",
	desc = "Run last debug adapter",
}

-- Database
maps.n["<leader>Du"] = { "<cmd>DBUIToggle<cr>", desc = "Toggle Database UI" }
maps.n["<leader>Df"] = {
	"<cmd>DBUIFindBuffer<cr>",
	desc = "Database Find Buffer",
}
maps.n["<leader>Dr"] = {
	"<cmd>DBUIRenameBuffer<cr>",
	desc = "Database Rename Buffer",
}
maps.n["<leader>Dq"] = {
	"<cmd>DBUILastQueryInfo<cr>",
	desc = "Database last query info",
}

-- Package info
maps.n["<leader>nv"] = {
	function()
		require("package-info").change_version()
	end,
	noremap = true,
	desc = "Change package.json version",
}
maps.n["<leader>ni"] = {
	function()
		require("package-info").install()
	end,
	noremap = true,
	desc = "Install package.json dependency",
}
maps.n["<leader>nd"] = {
	function()
		require("package-info").delete()
	end,
	silent = true,
	noremap = true,
	desc = "Delete package.json dependency",
}

-- LazyGit
maps.n["<leader>gg"] = {
	"<cmd>LazyGit<cr>",
	desc = "Open LazyGit",
}

-- GitSigns
maps.n["<leader>gj"] = {
	function()
		require("gitsigns").next_hunk()
	end,
	desc = "Next git hunk",
}
maps.n["<leader>gk"] = {
	function()
		require("gitsigns").prev_hunk()
	end,
	desc = "Previous git hunk",
}
maps.n["<leader>gl"] = {
	function()
		require("gitsigns").blame_line()
	end,
	desc = "View git blame",
}
maps.n["<leader>gL"] = {
	function()
		require("gitsigns").toggle_current_line_blame()
	end,
	desc = "View git blame",
}
maps.n["<leader>gd"] = {
	function()
		require("gitsigns").diffthis()
	end,
	desc = "View git diff",
}
maps.n["<leader>gh"] = {
	function()
		require("gitsigns").reset_hunk()
	end,
	desc = "Reset git hunk",
}
maps.n["<leader>gp"] = {
	function()
		require("gitsigns").preview_hunk()
	end,
	desc = "Preview git hunk",
}
maps.n["<leader>gr"] = {
	function()
		require("gitsigns").reset_buffer()
	end,
	desc = "Reset git buffer",
}
maps.n["<leader>gs"] = {
	function()
		require("gitsigns").stage_hunk()
	end,
	desc = "Stage git hunk",
}
maps.n["<leader>gu"] = {
	function()
		require("gitsigns").undo_stage_hunk()
	end,
	desc = "Unstage git hunk",
}

maps.n["<leader>so"] = { "<cmd>Sort<CR>", noremap = true, desc = "Sort" }
maps.v["<leader>so"] = { "<esc><cmd>Sort<CR>", noremap = true, desc = "Sort" }

maps.n["<leader>e"] = {
	"<cmd>lua vim.diagnostic.open_float()<CR>",
	noremap = true,
	desc = "Open diagnostic",
}
maps.n["<leader>rn"] = {
	"<cmd>lua vim.lsp.buf.rename()<CR>",
	noremap = true,
	desc = "LSP Rename",
}

maps.n["K"] = {
	function()
		require("pretty_hover").hover()
	end,
	desc = "Unstage git hunk",
}

maps.n["<C-e>"] = {
	"<cmd>Neotree toggle<CR>",
	desc = "Toggle neotree",
	silent = true,
}

maps.n["<C-y>"] = {
	"<cmd>lua require('leap').leap { target_windows = { vim.fn.win_getid() } }<CR>",
}

-- Monorepo
local function indexOrNextProject(can_go_next)
	local index = vim.v.count
	if index < 0 then
		if can_go_next then
			require("monorepo").next_project()
		end
		return
	end

	require("monorepo").go_to_project(index)
end

maps.n["<leader>nh"] = {
	function()
		require("telescope").extensions.notify.notify()
	end,
	desc = "Telescope notifications list",
}
maps.n["<leader>np"] = {
	function()
		require("telescope").extensions.monorepo.monorepo()
	end,
	desc = "Monorepo project list",
}
maps.n["<leader>nt"] = {
	function()
		require("monorepo").toggle_project()
	end,
	desc = "Monorepo toggle project",
}
maps.n["<leader>nn"] = {
	function()
		indexOrNextProject()
	end,
	desc = "Monorepo next project or prefixed index",
}
maps.n["<C-m>"] = {
	function()
		indexOrNextProject(false)
	end,
	desc = "Monorepo next project or prefixed index",
}

-- Smart Splits

-- Better window navigation
maps.n["<C-h>"] = {
	function()
		require("smart-splits").move_cursor_left()
	end,
	desc = "Move to left split",
}
maps.n["<C-j>"] = {
	function()
		require("smart-splits").move_cursor_down()
	end,
	desc = "Move to below split",
}
maps.n["<C-k>"] = {
	function()
		require("smart-splits").move_cursor_up()
	end,
	desc = "Move to above split",
}
maps.n["<C-l>"] = {
	function()
		require("smart-splits").move_cursor_right()
	end,
	desc = "Move to right split",
}

-- Resize with arrows
maps.n["<C-w>k"] = {
	function()
		require("smart-splits").resize_up()
	end,
	desc = "Resize split up",
}
maps.n["<C-w>j"] = {
	function()
		require("smart-splits").resize_down()
	end,
	desc = "Resize split down",
}
maps.n["<C-w>h"] = {
	function()
		require("smart-splits").resize_left()
	end,
	desc = "Resize split left",
}
maps.n["<C-w>l"] = {
	function()
		require("smart-splits").resize_right()
	end,
	desc = "Resize split right",
}

maps.n["<C-w>K"] = {
	function()
		require("smart-splits").swap_buf_up()
	end,
	desc = "Swap split up",
}
maps.n["<C-w>J"] = {
	function()
		require("smart-splits").swap_buf_down()
	end,
	desc = "Swap split down",
}
maps.n["<C-w>H"] = {
	function()
		require("smart-splits").swap_buf_left()
	end,
	desc = "Sawp split left",
}
maps.n["<C-w>L"] = {
	function()
		require("smart-splits").swap_buf_right()
	end,
	desc = "Swap split right",
}

-- Telescope
maps.n["<leader>fw"] = {
	function()
		require("telescope.builtin").live_grep()
	end,
	desc = "Search words",
}
maps.n["<leader>fW"] = {
	function()
		require("telescope.builtin").live_grep({
			additional_args = function(args)
				return vim.list_extend(args, { "--hidden", "--no-ignore" })
			end,
		})
	end,
	desc = "Search words in all files",
}
maps.n["<leader>gt"] = {
	function()
		require("telescope.builtin").git_status()
	end,
	desc = "Git status",
}
maps.n["<leader>gb"] = {
	function()
		require("telescope.builtin").git_branches()
	end,
	desc = "Git branches",
}
maps.n["<leader>gc"] = {
	function()
		require("telescope.builtin").git_commits()
	end,
	desc = "Git commits",
}

maps.n["<leader>ff"] = {
	function()
		require("telescope.builtin").find_files()
	end,
	desc = "Search files",
}
maps.n["<leader>fF"] = {
	function()
		require("telescope.builtin").find_files({
			hidden = true,
			no_ignore = true,
		})
	end,
	desc = "Search all files",
}
maps.n["<leader>sb"] = {
	function()
		require("telescope.builtin").buffers()
	end,
	desc = "Search buffers",
}
maps.n["<leader>fo"] = {
	function()
		require("telescope.builtin").oldfiles()
	end,
	desc = "Search history",
}
maps.n["<leader>fc"] = {
	function()
		require("telescope.builtin").grep_string()
	end,
	desc = "Search for word under cursor",
}
maps.n["<leader>sh"] = {
	function()
		require("telescope.builtin").help_tags()
	end,
	desc = "Search help",
}
maps.n["<leader>sr"] = {
	function()
		require("telescope.builtin").registers()
	end,
	desc = "Search registers",
}
maps.n["<leader>sk"] = {
	function()
		require("telescope.builtin").keymaps()
	end,
	desc = "Search keymaps",
}
maps.n["<leader>sc"] = {
	function()
		require("telescope.builtin").commands()
	end,
	desc = "Search commands",
}

maps.n["<leader>ls"] = {
	function()
		local aerial_avail, _ = pcall(require, "aerial")
		if aerial_avail then
			require("telescope").extensions.aerial.aerial()
		else
			require("telescope.builtin").lsp_document_symbols()
		end
	end,
	desc = "Search symbols",
}

-- end

maps.n["<leader>tn"] = { "<cmd>tabnew<cr>" }
maps.n["<leader>tc"] = { "<cmd>tabclose<cr>" }

-- Fix for toggleterm getting weird counts
local function runToggleTerm(args)
	local count = vim.v.count
	if count < 0 then
		count = ""
	end

	if not args then
		args = "direction=float"
	end

	vim.cmd(":ToggleTerm " .. count .. args)
end

maps.n["<leader>tf"] = {
	function()
		runToggleTerm()
	end,
	desc = "ToggleTerm float",
}
maps.n["<C-\\>"] = {
	function()
		runToggleTerm()
	end,
	desc = "ToggleTerm",
}
maps.n["<leader>th"] = {
	function()
		runToggleTerm("size=10 direction=horizontal")
	end,
	desc = "ToggleTerm horizontal split",
}
maps.n["<leader>tv"] = {
	function()
		runToggleTerm("size=80 direction=vertical")
	end,
	desc = "ToggleTerm vertical split",
}

maps.n["<F7>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" }
maps.t["<F7>"] = maps.n["<F7>"]

-- Improved Terminal Navigation
maps.t["<C-h>"] = {
	"<c-\\><c-n><c-w>h",
	desc = "Terminal left window navigation",
}
maps.t["<C-j>"] = {
	"<c-\\><c-n><c-w>j",
	desc = "Terminal down window navigation",
}
maps.t["<C-k>"] = {
	"<c-\\><c-n><c-w>k",
	desc = "Terminal up window navigation",
}
maps.t["<C-l>"] = {
	"<c-\\><c-n><c-w>l",
	desc = "Terminal right window navigation",
}

-- Generate types from json
maps.n["<leader>gj"] = {
	function()
		local language = vim.fn.input("Lang > ", "typescript")
		local top_level = vim.fn.input("Main type name > ")

		vim.cmd(".!quicktype -l " .. language .. " --no-enums --just-types --top-level " .. top_level)
	end,
	desc = "Generate types from current line json",
}

neovim.set_mappings(maps)
