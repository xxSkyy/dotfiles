return {
  {
    'saecki/crates.nvim',
    version = 'v0.2.1',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function() neovim.require('crates') end

  },
  'simrat39/rust-tools.nvim',
}
