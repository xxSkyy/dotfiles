-- require 'lspconfig'.sourcekit.setup {
--   capabilities = neovim.capabilities
-- }


local clangd = "clangd"

-- Mac path, modified for platformio and esp32 compatibility
if vim.fn.has('macunix') == 1 then
  clangd = vim.fn.expand('~/bin/clangd')
end

require 'lspconfig'.clangd.setup {
  capabilities = neovim.capabilities,
  cmd = {
    "clangd",
    "--background-index",
    "--offset-encoding=utf-16",
    "--query-driver=" .. vim.fn.expand("~/.platformio/packages/toolchain-xtensa-esp32s3/bin/xtensa-esp32s3-elf-gcc*")
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
}
