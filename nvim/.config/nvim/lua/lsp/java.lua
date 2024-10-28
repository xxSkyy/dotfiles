local capabilities = neovim.capabilities

local root_patterns = { "gradlew", "mvnw" }
local matcher = require("lspconfig").util.root_pattern(root_patterns)

local isJavaDir = matcher(vim.fn.getcwd())

if isJavaDir == nil then
	return
end

local jdtls = require("mason-core.path").bin_prefix("jdtls")
local config = {
	cmd = { jdtls },
	root_dir = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1]),
}

require("jdtls").start_or_attach(config)

require("lspconfig").jdtls.setup({
	cmd = { jdtls },
	capabilities = capabilities,
})
