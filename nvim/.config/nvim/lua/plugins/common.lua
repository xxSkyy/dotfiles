--- Put in this file all plugins
return {
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


  -- Inlay hints
  {
    "simrat39/inlay-hints.nvim",
    config = function() neovim.require('inlay-hints') end
  },


  -- Surround edits

  {
    'mrjones2014/smart-splits.nvim',
    config = function() neovim.require('smart-splits') end
  },

  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    config = function()
      require('ufo').setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end
      })
    end
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

  -- Telescope

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
          'svelte',
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

  -- Multiple terminals, floating etc
  { "akinsho/toggleterm.nvim", version = '*' },

  -- Shows git decorations
  {
    'lewis6991/gitsigns.nvim',
    config = function() neovim.require('gitsigns') end
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
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.60)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { focusable = false })
      end,
      render = "default",
      stages = "fade_in_slide_out",
    },
    config = function()
      require("notify").setup({ background_colour = "#000000" })
    end
  },

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
}
