local telescope = require "telescope"
local actions = require "telescope.actions"

telescope.setup {
  defaults = {
    prompt_prefix = string.format("%s ", neovim.get_icon "Search"),
    selection_caret = string.format("%s ", neovim.get_icon "Selected"),
    path_display = { "truncate" },
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        preview_cutoff = 40,
        preview_width = 1,
        wrap_results = true,
        prompt_position = "top"
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },

    mappings = {
      i = {
        ["<Tab>"] = actions.move_selection_next,
        ["<S-Tab>"] = actions.move_selection_previous,
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
      n = { ["q"] = actions.close },
    },
  },
}

telescope.load_extension("live_grep_args")
telescope.load_extension("monorepo")
telescope.load_extension("notify")
