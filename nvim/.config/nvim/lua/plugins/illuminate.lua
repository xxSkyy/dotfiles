  -- Show matching words
  return {
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
  }
