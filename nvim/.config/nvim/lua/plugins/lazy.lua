--- Put in this file all plugins
require('lazy').setup({
  -- LSP
  'neovim/nvim-lspconfig',
  "lukas-reineke/lsp-format.nvim",

  -- LSP UI Installer
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {

      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
      -- Snippets engine
      {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
      },
    }
  },

  -- Inlay hints
  {
    "simrat39/inlay-hints.nvim",
    config = function() neovim.require('inlay-hints') end
  },

  -- Surround edits
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function() neovim.require('nvim-surround') end
  },

  {
    'mrjones2014/smart-splits.nvim',
    config = function() neovim.require('smart-splits') end
  },

  { 'kevinhwang91/nvim-ufo',    dependencies = 'kevinhwang91/promise-async' },

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

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { "nvim-telescope/telescope-live-grep-args.nvim" }
    }
  },

  -- Sort lines
  "sQVe/sort.nvim",

  -- Window picker
  {
    's1n7ax/nvim-window-picker',
    version = 'v1.*',
    config = function()
      neovim.require('window-picker', {
        autoselect_one = true,
        include_current = false,
        filter_rules = {
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { 'neo-tree', "neo-tree-popup", "notify" },
            -- if the buffer type is one of following, the window will be ignored
            buftype = { 'terminal', "quickfix" }
          }
        },
        other_win_hl_color = '#e35e4f'
      })
    end
  },

  {
    "tiagovla/scope.nvim",
    config = function() neovim.require('scope') end
  },

  -- Code action menu
  { 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu' }, -- Better UI

  {
    'stevearc/dressing.nvim',
    config = function() neovim.require('dressing') end
  },

  -- Tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim"
    }
  },

  -- Start screen
  { 'mhinz/vim-startify' },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true }
  },

  -- Tabs
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons'
  },

  -- Close current buffer
  {
    'kazhala/close-buffers.nvim',
    config = function()
      neovim.require("close_buffers", {
        preserve_window_layout = { 'this' },
        next_buffer_cmd = function(windows)
          require('bufferline').cycle(1)
          local bufnr = vim.api.nvim_get_current_buf()

          for _, window in ipairs(windows) do
            vim.api.nvim_win_set_buf(window, bufnr)
          end
        end
      })
    end
  },

  -- Themes
  "EdenEast/nightfox.nvim",
  "rebelot/kanagawa.nvim",

  -- Multi cursor
  "mg979/vim-visual-multi",

  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function() neovim.require('trouble') end
  },

  -- Formatter
  "MunifTanjim/prettier.nvim",

  -- Jumping over words
  "ggandor/leap.nvim",

  "folke/lua-dev.nvim",

  {
    "imNel/monorepo.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"
    },
    config = function()
      neovim.require("monorepo", { autoload_telescope = false })
    end
  },

  -- Treesitter autoclose and autorename html tags
  {
    "windwp/nvim-ts-autotag",
    config = function() neovim.require('nvim-ts-autotag') end
  },

  -- Rust
  {
    'saecki/crates.nvim',
    version = 'v0.2.1',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function() neovim.require('crates') end

  },
  'simrat39/rust-tools.nvim',

  -- Godot
  "habamax/vim-godot",

  -- Multiple terminals, floating etc
  { "akinsho/toggleterm.nvim",                     version = '*' },

  -- Shows git decorations
  {
    'lewis6991/gitsigns.nvim',
    config = function() neovim.require('gitsigns') end
  },

  -- LazyGit
  {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  -- Colorize hex color
  'NvChad/nvim-colorizer.lua',

  -- Show matching words
  {
    "RRethy/vim-illuminate",
    config = function()
      if not neovim.is_vscode() then
        require('illuminate').configure({
          modes_denylist = { 'v' },
          providers = {
            'lsp',
            -- 'treesitter',
            'regex',
          },
        })
      end
    end
  },

  -- Fancy notifications
  {
    'rcarriga/nvim-notify',
    config = function()
      require("notify").setup({ background_colour = "#000000" })
    end
  },

  -- Key helper
  {
    "folke/which-key.nvim",
    config = function() neovim.require('which-key') end
  }, -- Java

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
        vim.api.nvim_set_hl(0, "AutumnRed", { fg = "#621E21" }) -- Dimmed AutumnRed
        vim.api.nvim_set_hl(0, "OchreYellow", { fg = "#6E522F" }) -- Dimmed OchreYellow
        vim.api.nvim_set_hl(0, "WaveBlue", { fg = "#3F5A65" }) -- Dimmed WaveBlue
        vim.api.nvim_set_hl(0, "PeachRed", { fg = "#80501D" }) -- Dimmed PeachRed
        vim.api.nvim_set_hl(0, "SpringGreen", { fg = "#3B4A35" }) -- Dimmed SpringGreen
        vim.api.nvim_set_hl(0, "LightViolet", { fg = "#4B3D5C" }) -- Dimmed LightViolet
        vim.api.nvim_set_hl(0, "Teal", { fg = "#3D5450" })  -- Dimmed Teal
      end)

      require("ibl").setup { indent = { highlight = highlight } }
    end
  },

  -- Another commenting
  "JoosepAlviste/nvim-ts-context-commentstring",


  -- Arduino
  'stevearc/vim-arduino',
  'edKotinsky/Arduino.nvim',

  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }
  },

  {
    "jayp0521/mason-null-ls.nvim",
    config = function() neovim.require('mason-null-ls') end
  },

  -- Package json helper
  {
    "vuki656/package-info.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    config = function() neovim.require('package-info') end
  },

  -- Better UI
  {
    "folke/noice.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" }
  },

  -- LSP loading progress
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    opts = {
      -- options
    }
  },

  { "davidosomething/format-ts-errors.nvim" },

  -- Lsp lines errors
  { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },

  {
    'ThePrimeagen/harpoon',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  -- Pretty hover
  { "Fildo7525/pretty_hover" },

  -- SQL LSP
  'nanotee/sqls.nvim',

  -- Database
  {
    "tpope/vim-dadbod",
    lazy = true,

    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion"
    },

    config = function()
      vim.g.db_ui_save_location = vim.fn.stdpath "config" ..
          require("plenary.path").path.sep ..
          "db_ui"

      -- vim.api.nvim_create_autocmd("FileType", {
      --   pattern = {
      --     "sql",
      --   },
      --   command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
      -- })

      vim.api.nvim_create_autocmd("FileType",
        { pattern = { "sql", "mysql", "plsql" } })
    end,

    cmd = {
      "DBUIToggle",
      "DBUI",
      "DBUIAddConnection",
      "DBUIFindBuffer",
      "DBUIRenameBuffer",
      "DBUILastQueryInfo"
    }
  }
})
