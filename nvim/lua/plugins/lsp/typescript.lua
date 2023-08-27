local have_vue = neovim.is_npm_package_installed 'vue'


if not have_vue then
  require 'lspconfig'.tsserver.setup {
    root_dir = require 'lspconfig'.util.root_pattern("package.json"),
    server = {
      on_attach = require("lsp-format").on_attach,
      capabilities = neovim.capabilities
    },
    -- neovim.is_npm_package_installed 'vue' and {} or
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    single_file_support = false,
    init_options = {
      preferences = {
        importModuleSpecifierPreference = "non-relative"
      }
    },
    handlers = {
      ["textDocument/publishDiagnostics"] = function(
      _,
      result,
      ctx,
      config
      )
        if result.diagnostics == nil then
          return
        end

        -- ignore some tsserver diagnostics
        local idx = 1
        while idx <= #result.diagnostics do
          local entry = result.diagnostics[idx]

          local formatter = require('format-ts-errors')[entry.code]
          entry.message = formatter and formatter(entry.message) or entry.message

          -- codes: https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
          if entry.code == 80001 then
            -- { message = "File is a CommonJS module; it may be converted to an ES module.", }
            table.remove(result.diagnostics, idx)
          else
            idx = idx + 1
          end
        end

        vim.lsp.diagnostic.on_publish_diagnostics(
          _,
          result,
          ctx,
          config
        )
      end,
    }
  }
end
