for _, source in ipairs({ "utils" }) do
	local status_ok, fault = pcall(require, source)
	if not status_ok then
		vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault)
	end
end

require("config.vars")
require("config.options")
require("config.plugins")
require("config.mappings")
