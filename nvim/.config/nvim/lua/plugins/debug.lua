return {
	-- Debug Adapter Protocol
	"mfussenegger/nvim-dap",
	{
		"rcarriga/nvim-dap-ui",
		config = function()
			neovim.require("dapui")
		end,
	},
}
