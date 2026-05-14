return {
  "chrisgrieser/nvim-spider",
  lazy = true,
  enabled = false,
  config = {
    subwordMovement = false
  },
  keys = {
    { -- This is to have same behavior for this command as in vanilla neovim
      "dw",
      "d<cmd>lua require('spider').motion('e')<CR>",
      mode = { "n" },
    },
    { -- This is to have same behavior for this command as in vanilla neovim
      "cw",
      "c<cmd>lua require('spider').motion('e')<CR>",
      mode = { "n" },
    },
    {
      "b",
      "<cmd>lua require('spider').motion('b')<CR>",
      mode = { "n", "o", "x" },
    },
    {
      "w",
      "<cmd>lua require('spider').motion('w')<CR>",
      mode = { "n", "o", "x" },
    },
    {
      "e",
      "<cmd>lua require('spider').motion('e')<CR>",
      mode = { "n", "o", "x" },
    },
    -- ...
  },
}
