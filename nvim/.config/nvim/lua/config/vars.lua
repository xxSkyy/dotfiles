--[[ vars.lua ]]
local g = vim.g
g.t_co = 256
g.background = "dark"

g.mapleader = ","
g.localleader = "\\"

-- To appropriately highlight codefences returned from denols,
-- you will need to augment vim.g.markdown_fenced languages
-- in your init.lua
g.markdown_fenced_languages = {
	"ts=typescript",
}
