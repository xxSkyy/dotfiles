require('neotest').setup({
  adapters = {
    require('neotest-vitest'),
    require('neotest-jest'),
    require("neotest-rust"),
  },
  on_attach = function()
    -- TODO: Mappings on <leader>e..
  end
})
