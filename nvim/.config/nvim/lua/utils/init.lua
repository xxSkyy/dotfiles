_G.neovim = {}

local map = vim.keymap.set

function neovim.initialize_icons()
	neovim.icons = require("utils.icons.nerd_font")
	neovim.text_icons = require("utils.icons.text")
end

function neovim.get_clean_mappings()
	local maps = { i = {}, n = {}, v = {}, t = {}, [""] = {} }

	return maps
end

--- Get an icon from `lspkind` if it is available and return it
-- @param kind the kind of icon in `lspkind` to retrieve
-- @return the icon
function neovim.get_icon(kind)
	local icon_pack = vim.g.icons_enabled and "icons" or "text_icons"
	if not neovim[icon_pack] then
		neovim.initialize_icons()
	end
	return neovim[icon_pack] and neovim[icon_pack][kind] or ""
end

function neovim.set_mappings(map_table, base)
	-- iterate over the first keys for each mode
	for mode, maps in pairs(map_table) do
		-- iterate over each keybinding set in the current mode
		for keymap, options in pairs(maps) do
			-- build the options for the command accordingly
			if options then
				local cmd = options
				local keymap_opts = base or {}
				if type(options) == "table" then
					cmd = options[1]
					keymap_opts = vim.tbl_deep_extend("force", options, keymap_opts)
					keymap_opts[1] = nil
				end
				-- extend the keybinding options with the base provided and set the mapping
				map(mode, keymap, cmd, keymap_opts)
			end
		end
	end
end

---- Check if module is already initialized
-- function neovim.is_available(plugin) return lazy_plugins~= nil and packer_plugins[plugin] ~= nil end

---- Check if module is just installed, no need
-- to be initialized already.
function neovim.is_module_available(name)
	if package.loaded[name] then
		return true
	else
		for _, searcher in ipairs(package.searchers or package.loaders) do
			local loader = searcher(name)
			if type(loader) == "function" then
				package.preload[name] = loader
				return true
			end
		end
		return false
	end
end

function neovim.load_folder(path)
	for _, file in
		ipairs(vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/" .. path:gsub("%.", "/"), [[v:val =~ '\.lua$']]))
	do
		require(path .. "." .. file:gsub("%.lua$", ""))
	end
end

function neovim.is_vscode()
	return vim.g.vscode ~= nil
end

-- dependencies only when it's not under vscode
function neovim.require(
	package, --[[optional]]
	settings, --[[optional]]
	on_vscode
)
	on_vscode = on_vscode or false
	settings = settings or {}

	if neovim.is_vscode() and on_vscode == false then
		return
	end

	require(package).setup(settings)
end

function neovim.read_json_file(filename)
	local Path = require("plenary.path")

	local path = Path:new(filename)
	if not path:exists() then
		return nil
	end

	local json_contents = path:read()
	local json = vim.fn.json_decode(json_contents)

	return json
end

function neovim.read_package_json()
	return neovim.read_json_file("package.json")
end

---Check if the given NPM package is installed in the current project.
---@param package string
---@return boolean
function neovim.is_npm_package_installed(package)
	local package_json = neovim.read_package_json()
	if not package_json then
		return false
	end

	if package_json.dependencies and package_json.dependencies[package] then
		return true
	end

	if package_json.devDependencies and package_json.devDependencies[package] then
		return true
	end

	return false
end

function neovim.generate_uuid()
	local random = math.random
	local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
	return string.gsub(template, "[xy]", function(c)
		local v = (c == "x") and random(0, 0xf) or random(8, 0xb)
		return string.format("%x", v)
	end)
end

local has_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

if has_cmp_nvim_lsp then
	local lspconfig = require("lspconfig")
	local lsp_defaults = lspconfig.util.default_config

	neovim.capabilities = lsp_defaults.capabilities
end
