-- crates version helper
require('crates').setup()

local extension_path = vim.env.HOME .. '/.vscode-oss/extensions/vadimcn.vscode-lldb-1.8.1/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

local rt = require("rust-tools")

-- rust analuzer
local server = {
  on_attach    = function(client, bufnr)
    require("lsp-format").on_attach(client)
    vim.keymap.set(
      "n",
      "K",
      rt.hover_actions.hover_actions,
      { buffer = bufnr }
    )

    -- Not needed CodeAction menu works with Rust Tools
    -- vim.keymap.set(
    --   "n",
    --   "<Leader>a",
    --   rt.code_action_group.code_action_group,
    --   { buffer = bufnr }
    -- )
  end,
  capabilities = neovim.capabilities,
  settings     = {
    -- to enable rust-analyzer settings visit:
    -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
    ["rust-analyzer"] = {
      completion = {
        addcallargumentsnippets = false,
        postfix = {
          enable = false
        }
      },
      checkonsave = {
        command = "clippy"
      },

      rustfmt = {
        extraArgs = { '--config', 'max_width=60' }
      },
    }
  }
}

rt.setup({
  server = server,
  tools = {
    runnables = {
      use_telescope = true,
    },
    inlay_hints = {
      auto = true,
      show_parameter_hints = true,
      -- parameter_hints_prefix = "",
      -- other_hints_prefix = "",
    },
  },
  dap = {
    adapter = require('rust-tools.dap').get_codelldb_adapter(
      codelldb_path,
      liblldb_path
    )
  }
})
