return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  -- version = "2.*",
  -- init = function()
  --   vim.o.timeout = true
  --   vim.o.timeoutlen = 300
  -- end,

  dependencies = {
    { 'echasnovski/mini.icons', version = false },
  },

  config = function()
    local wk = require("which-key")

    wk.setup({
      delay = 300,
      plugins = {
        marks = false,
        registers = false,
        spelling = {
          enabled = false
        },
        presets = {
          operators = false, -- adds help for operators like d, y, ...
          motions = false, -- adds help for motions
          text_objects = false, -- help for text objects triggered after entering an operator
          windows = false, -- default bindings on <c-w>
          nav = false, -- misc bindings to work with windows
          v = false,
          V = false,
          z = false, -- bindings for folds, spelling and others prefixed with z
          g = false, -- bindings for prefixed with g
        },
      },
    })

    wk.add({
      {"<leader>g", group = "Git"},
      {"<leader>b", group = "Buffer"},
      {"<leader>c", group = "Code actions"},
      {"<leader>d", group = "Debug"},
      {"<leader>e", group = "Errors"},
      {"<leader>f", group = "Files"},
      {"<leader>h", group = "Help"},
      {"<leader>k", group = "Kalula"},
      {"<leader>K", group = "Kalula Picker"},
      {"<leader>l", group = "Lsp"},
      {"<leader>m", group = "Marks"},
      {"<leader>p", group = "Swap Parameters"},
      {"<leader>o", group = "Open"},
      {"<leader>s", group = "Search"},
      {"<leader>S", group = "Snippet"},
      {"<leader>t", group = "tabs/terminal"},
      {"<leader>T", group = "Tabs"},
      {"<leader>u", group = "Undo tree"},
    })
  end
}
