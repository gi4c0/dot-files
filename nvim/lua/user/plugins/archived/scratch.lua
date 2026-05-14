return {
  'mtth/scratch.vim',
  enabled = false,

  keys = {
    {'<leader>bs', ':Scratch<CR>', noremap = true, silent = true }
  },

  init = function()
    --  Open the scratch window in a horizontal split instead of a vertical one
    vim.g.scratch_horizontal = 0
    vim.g.scratch_top = 0
    vim.g.scratch_no_mappings = 1

    vim.g.scratch_height = 100
    vim.g.scratch_autohide = 0
  end
}
