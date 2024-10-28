--- Put in this file all plugins
return {
  -- LSP
  'neovim/nvim-lspconfig',
  "lukas-reineke/lsp-format.nvim",

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },


  -- Inlay hints
  {
    "simrat39/inlay-hints.nvim",
    config = function() neovim.require('inlay-hints') end
  },



  -- Filesystem navigation & icons
  { 'kyazdani42/nvim-tree.lua', dependencies = 'nvim-tree/nvim-web-devicons' },
  {
    {
      "antosha417/nvim-lsp-file-operations",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-tree.lua",
      },
      config = function()
        require("lsp-file-operations").setup()
      end,
    },
  },

  -- Comment out engine
  {
    "numToStr/Comment.nvim",
    config = function() neovim.require('Comment', {}, true) end
  },


  -- Sort lines
  "sQVe/sort.nvim",



  -- Code action menu
  { 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu' }, -- Better UI

  {
    'stevearc/dressing.nvim',
    config = function() neovim.require('dressing') end
  },


  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true }
  },


  -- Themes
  "EdenEast/nightfox.nvim",
  "rebelot/kanagawa.nvim",

  -- Multi cursor
  "mg979/vim-visual-multi",


  -- Formatter
  "MunifTanjim/prettier.nvim",

  -- Jumping over words
  "ggandor/leap.nvim",


  -- Treesitter autoclose and autorename html tags
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require('nvim-ts-autotag').setup({

        enable = true,
        enable_close_on_slash = false,
        filetypes = {
          'html',
          'javascript',
          'typescript',
          'javascriptreact',
          'typescriptreact',
          'vue',
          'tsx',
          'jsx',
          'rescript',
          'xml',
          'php',
          'markdown',
          'glimmer',
          'handlebars',
          'hbs',
          'rust',
          'go',
        }
      })
    end
  },

  -- Godot
  "habamax/vim-godot",

  -- Colorize hex color
  'NvChad/nvim-colorizer.lua',

  -- Key helper
  {
    "folke/which-key.nvim",
    config = function() neovim.require('which-key') end
  },

  -- Java
  'mfussenegger/nvim-jdtls',

  -- Auto pairs plugin
  "windwp/nvim-autopairs",


  -- Debug Adapter Protocol
  'mfussenegger/nvim-dap',
  {
    'rcarriga/nvim-dap-ui',
    config = function() neovim.require('dapui') end
  },

  -- Testing
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      'marilari88/neotest-vitest', "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim", "haydenmeade/neotest-jest",
      "rouge8/neotest-rust"
    }
  },

  -- Show indentation etc
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = function()
      local highlight = {
        "OchreYellow",
        "WaveBlue",
        "PeachRed",
        "SpringGreen",
        "LightViolet",
        "Teal",
        "AutumnRed",
      }

      local hooks = require "ibl.hooks"

      -- Create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "AutumnRed", { fg = "#621E21" })   -- Dimmed AutumnRed
        vim.api.nvim_set_hl(0, "OchreYellow", { fg = "#6E522F" }) -- Dimmed OchreYellow
        vim.api.nvim_set_hl(0, "WaveBlue", { fg = "#3F5A65" })    -- Dimmed WaveBlue
        vim.api.nvim_set_hl(0, "PeachRed", { fg = "#80501D" })    -- Dimmed PeachRed
        vim.api.nvim_set_hl(0, "SpringGreen", { fg = "#3B4A35" }) -- Dimmed SpringGreen
        vim.api.nvim_set_hl(0, "LightViolet", { fg = "#4B3D5C" }) -- Dimmed LightViolet
        vim.api.nvim_set_hl(0, "Teal", { fg = "#3D5450" })        -- Dimmed Teal
      end)

      require("ibl").setup { indent = { highlight = highlight } }
    end
  },

  -- Another commenting
  "JoosepAlviste/nvim-ts-context-commentstring",

  -- Package json helper
  {
    "vuki656/package-info.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    config = function() neovim.require('package-info') end
  },

  -- SQL LSP
  'nanotee/sqls.nvim',
}
