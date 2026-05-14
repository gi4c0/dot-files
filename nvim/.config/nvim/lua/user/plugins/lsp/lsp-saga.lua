return {
  'nvimdev/lspsaga.nvim',
  enabled = true,
  cond = vim.env.COC ~= '1',
  opts = {
    rename = {
      auto_save = true,
      quit = "<C-c>",
      exec = "<CR>",
      mark = "x",
      confirm = "<CR>",
      in_select = false,
    },
    symbol_in_winbar = {
      enable = false
    },
    project_replace = {
      quit = '<ESC>',
      select = '<TAB>'
    },
    lightbulb = {
      enable = false,
      enable_in_insert = true,
      sign = true,
      sign_priority = 40,
      virtual_text = true,
    },
    finder = {
      keys = {
        toggle_or_open = '<CR>',
        quit = '<ESC>'
      }
    },
    implement = {
      enable = false
    }
  },

  keys = {
    -- Code action
    {"<leader>ca", "<cmd>Lspsaga code_action<CR>", desc = "Menu" },

    -- Rename all occurrences of the hovered word for the selected files
    {"<leader>cr", "<cmd>Lspsaga rename<CR>", desc = "Rename" },

    -- Peek definition
    -- You can edit the file containing the definition in the floating window
    {"gD", ":Lspsaga peek_definition<CR>", {noremap = true } },

    -- Go to definition
    -- {"gd", "<cmd>Lspsaga goto_definition<CR>" },

    -- Peek type definition
    -- You can edit the file containing the type definition in the floating window
    -- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
    -- It also supports tagstack
    -- Use <C-t> to jump back
    {"gT", "<cmd>Lspsaga peek_type_definition<CR>" },

    -- Go to type definition
    -- {"gt", "<cmd>Lspsaga goto_type_definition<CR>" },


    -- Show line diagnostics
    -- You can pass argument ++unfocus to
    -- unfocus the show_line_diagnostics floating window
    -- keymap("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>")

    -- Hover Doc
    -- If there is no hover doc,
    -- there will be a notification stating that
    -- there is no information available.
    -- To disable it just use ":Lspsaga hover_doc ++quiet"
    -- Pressing the key twice will enter the hover window
    -- {"K", "<cmd>Lspsaga hover_doc<CR>" },

    -- {"gr", ":Lspsaga finder<CR>" },
  }
}
