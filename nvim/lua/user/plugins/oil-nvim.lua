return {
  'stevearc/oil.nvim',
  enabled = false,
  config = function()
    local oil = require("oil")

    oil.setup({
      view_options = {
          show_hidden = true
      },
      float = {
        border = 'single',
        max_width = 125,
        max_height = 30
      },
      lsp_file_methods = {
        enabled = true,
        timeout_ms = 1000 * 10,
        -- Set to true to autosave buffers that are updated with LSP willRenameFiles
        -- Set to "unmodified" to only save unmodified buffers
        autosave_changes = true,
      },
      keymaps = {
        -- ["<C-h>"] = "actions.parent",
        ["<C-s>"] = { callback = function() vim.cmd [[ write ]] end, mode = "n" },
        -- ["<C-l>"] = "actions.select",
        ["<C-v>"] = { "actions.select", opts = { vertical = true } },
        ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
        ["h"] = { "actions.parent", mode = "n" },
        ["l"] = { "actions.select", mode = "n" },
        ["q"] = { "actions.close", mode = "n" },
        ["Q"] = { "actions.close", mode = "n" },
        ["<C-q>"] = { "actions.send_to_qflist", mode = {"n", "v"} },
      }
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "OilEnter",
      callback = vim.schedule_wrap(function(args)
        if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
          oil.open_preview()
        end
      end),
    })
  end,
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons

  keys = {
    {'-', '<CMD>Oil --float<CR>', { desc = "Open parent directory" }},
    {'<leader>r', '<CMD>Oil --float<CR>', { desc = "Open parent directory" }},
    {'<leader>R', function() require('oil').open_float(vim.uv.cwd()) end, { desc = "Open parent directory" }},
    { "<C-f>", function() require('user.libs.snacks-dirs').find_dirs(function(path) require('oil').open_float(path) end) end, desc = "Find directories" },
    {'<leader>kf', function() require('oil').open_float(vim.uv.cwd() .. '/kulala') end}
  }
}
