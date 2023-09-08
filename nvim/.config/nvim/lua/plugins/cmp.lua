-- Autocompletion
local cmp = require 'cmp'
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup {
  source_priority = {
    nvim_lsp = 1000,
    luasnip = 750,
    buffer = 500,
    path = 250,
    text = 10,
  },
  sources = {
    { name = 'crates' },
    { name = 'rust-analyzer' },
    { name = 'treesitter' },
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    -- { name = "luasnip" },
    { name = "vim-dadbod-completion" }
  },
  mapping = {
    ['<Tab>'] = function(fallback)
      local luasnip = require 'luasnip'

      if cmp.visible() then
        cmp.select_next_item()
        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
        -- they way you will only jump inside the snippet region
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      local luasnip = require 'luasnip'

      if cmp.visible() then
        cmp.select_prev_item()
        -- elseif luasnip.jumpable( -1) then
        --   luasnip.jump( -1)
      else
        fallback()
      end
    end,
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true })
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  formatting = {
    format = function(_, vim_item)
      vim_item.kind = require("lspkind").presets.codicons[vim_item.kind]
          .. "  "
          .. vim_item.kind
      return vim_item
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  }
}

cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)


local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities(),
  { workspace = {
    didChangeWatchedFiles = {
      dynamicRegistration = true
    }
  } },
  {
    textDocument = { foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
    } }

  }
)

neovim.capabilities = lsp_defaults.capabilities