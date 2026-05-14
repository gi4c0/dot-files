return {
  "folke/trouble.nvim",
  opts = {},
  cmd = "Trouble",
  cond = vim.env.COC ~= '1',
  keys = {
    {
      "<leader>eL",
      "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<CR>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>el",
      "<cmd>Trouble diagnostics toggle filter.buf=0 focus=true filter.severity=vim.diagnostic.severity.ERROR<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    -- {
    --   "gr",
    --   "<cmd>Trouble lsp_references toggle focus=true win.position=bottom win.size.height=16<cr>",
    --   desc = "LSP Definitions / references / ... (Trouble)",
    -- },
  },
}
