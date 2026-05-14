return {
  'christoomey/vim-tmux-navigator',
  init = function()
    vim.g['tmux_navigator_no_mappings'] = 1
  end,

  keys = {
    {"<C-h>", ":<C-U>TmuxNavigateLeft<cr>", noremap = true, silent = true },
    {"<C-j>", ":<C-U>TmuxNavigateDown<cr>", noremap = true, silent = true },
    {"<C-k>", ":<C-U>TmuxNavigateUp<cr>", noremap = true, silent = true },
    {"<C-l>", ":<C-U>TmuxNavigateRight<cr>", noremap = true, silent = true },
  }
}
