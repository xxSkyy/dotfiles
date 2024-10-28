local clangd = "clangd"

-- Mac path, modified for platformio and esp32 compatibility
if vim.fn.has("macunix") == 1 then
	clangd = vim.fn.expand("~/.espressif/tools/esp-clang/16.0.1-fe4f10a809/esp-clang/bin/clangd")
end

local clangd_mason = require("mason-core.path").bin_prefix("clangd")

require("lspconfig").clangd.setup({
	capabilities = neovim.capabilities,
	cmd = {
		clangd_mason,
		-- "clangd",
		-- "$HOME/.espressif/tools/esp-clang/16.0.1-fe4f10a809/esp-clang/bin/clangd",
		"--background-index",
		"--offset-encoding=utf-16",
		-- "--query-driver=" .. vim.fn.expand("~/.platformio/packages/toolchain-xtensa-esp32s3/bin/xtensa-esp32s3-elf-gcc")
		"--query-driver=$HOME/.espressif/tools/xtensa-esp-elf/xtensa-esp32s3-elf/bin/xtensa-esp32s3-elf-gcc*",
	},
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
})
