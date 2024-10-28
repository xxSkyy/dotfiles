-- Packer file
-- require("plugins.packer")
require("config.lazy")
require("config.theme")


-- If Nvim is not running under VSCode enable those extensions
if not neovim.is_vscode() then
  if vim.g.lsp_setup_ready == nil then
    vim.g.lsp_setup_ready = true
    require('config.cmp')

    -- Plugin custom configs
    neovim.load_folder("configs")

    -- Lsp configs only pure nvim
    neovim.load_folder("lsp")
  end
end
