neovim.capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

local language_servers = require("lspconfig").util.available_servers()

for _, ls in ipairs(language_servers) do
  require('lspconfig')[ls].setup({
    capabilities = neovim.capabilities
  })
end

require('ufo').setup()
