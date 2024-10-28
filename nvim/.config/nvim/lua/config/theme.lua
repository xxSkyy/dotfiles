local nightfox_shade = require("nightfox.lib.shade")

local palettes = {
  duskfox = {
    black = nightfox_shade.new("#393552", "#47407d", "#322e42"),
    red = nightfox_shade.new("#eb6f92", "#f083a2", "#d84f76"),
    green = nightfox_shade.new("#a3be8c", "#b1d196", "#8aa872"),
    yellow = nightfox_shade.new("#dbc074", 0.15, -0.15),
    blue = nightfox_shade.new("#569fba", "#65b1cd", "#4a869c"),
    magenta = nightfox_shade.new("#9d79d6", 0.15, -0.15),
    cyan = nightfox_shade.new("#9ccfd8", "#a6dae3", "#7bb8c1"),
    white = nightfox_shade.new("#dddddf", 0.15, -0.15),
    orange = nightfox_shade.new("#ea9a97", "#f0a4a2", "#d6746f"),
    pink = nightfox_shade.new("#eb98c3", "#f0a6cc", "#d871a6"),

    comment = "#817c9c",

    bg0 = "#222020",  -- Dark bg (status line and float)
    -- bg0 = "#171616", -- Dark bg (status line and float)
    bg1 = "#161615",  -- Default bg
    bg2 = "#30302F",  -- Lighter bg (colorcolm folds)
    bg3 = "#30302F",  -- Lighter bg (cursor line)
    bg4 = "#4b4673",  -- Conceal, border fg

    fg0 = "#d6d6d7",  -- Lighter fg
    fg1 = "#cdcecf",  -- Default fg
    fg2 = "#aeafb0",  -- Darker fg (status line)
    fg3 = "#4b4673",  -- Darker fg (line numbers, fold colums)

    sel0 = "#433c59", -- Popup bg, visual selection bg
    sel1 = "#63577d"  -- Popup sel bg, search bg
  }
}

-- require('nightfox').setup({
--   palettes = palettes,
--   options = {
--     transparent = true,
--     styles = {
--       comments = "italic",
--       keywords = "italic",
--       types = "italic,bold",
--     }
--   },
--   groups = {
--     all = {
--       NormalFloat = { fg = "fg1", bg = "NONE", },
--     }
--   }
--
-- })

require('kanagawa').setup({
  compile = false,  -- enable compiling the colorscheme
  undercurl = true, -- enable undercurls
  commentStyle = { italic = true },
  keywordStyle = { italic = true },
  statementStyle = { bold = true },
  typeStyle = {},
  transparent = false,   -- do not set background color
  dimInactive = true,    -- dim inactive window `:h hl-NormalNC`
  terminalColors = true, -- define vim.g.terminal_color_{0,17}
  colors = {             -- add/modify theme and palette colors
    palette = {},
    theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
  },
  overrides = function(colors)
    local theme = colors.theme
    return {
      NormalFloat = { bg = "none" },
      FloatBorder = { bg = "none" },
      FloatTitle = { bg = "none" },

      -- Save an hlgroup with dark background and dimmed foreground
      -- so that you can use it where your still want darker windows.
      -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
      NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

      -- Popular plugins that open floats will link to NormalFloat by default;
      -- set their background accordingly if you wish to keep them dark and borderless
      LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
      MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

      -- Treesitter-specific customizations (VSCode Dark+ inspired theme)
      -- ["@comment"] = { fg = "#608B4E", italic = true }, -- Greenish grey for comments
      -- ["@keyword"] = { fg = "#569CD6", bold = true },   -- Blue for keywords
      -- ["@string"] = { fg = "#CE9178" },                 -- Reddish for strings
      -- ["@function"] = { fg = "#DCDCAA", bold = true },  -- Light yellow for functions
      -- ["@variable"] = { fg = "#9CDCFE" },               -- Light blue for variables
      -- ["@type"] = { fg = "#4EC9B0" },                   -- Aquamarine for types
      -- ["@constant"] = { fg = "#B5CEA8" },               -- Greenish for constants
      -- ["@parameter"] = { fg = "#DCDCAA" },              -- Light yellow for parameters
      -- ["@punctuation"] = { fg = "#D4D4D4" },            -- Light gray for punctuation

      -- Additional customizations for finer control
      ["@text.todo"] = { fg = "#569CD6", bold = true },                  -- Blue for TODO
      ["@text.note"] = { fg = "#4EC9B0", italic = true },                -- Aquamarine for notes
      ["@text.warning"] = { fg = "#D7BA7D", bold = true },               -- Orange for warnings
      ["@text.danger"] = { fg = "#F44747", bold = true, italic = true }, -- Red for dangers

    }
  end,
  theme = "wave",  -- Load "wave" theme when 'background' option is not set
  background = {   -- map the value of 'background' option to a theme
    dark = "wave", -- try "dragon" !
    light = "lotus"
  },
})

vim.cmd([[colorscheme kanagawa]])
