local jdtls = require 'mason-core.path'.bin_prefix 'jdtls'
local capabilities = neovim.capabilities

local config = {
  cmd = { jdtls },
  root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
}

require('jdtls').start_or_attach(config)


require 'lspconfig'.jdtls.setup {
  cmd = { jdtls },
  capabilities = capabilities
}
