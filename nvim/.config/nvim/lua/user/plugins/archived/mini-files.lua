return {
  'echasnovski/mini.nvim',
  version = false,
  enabled = false,
  config = function()
    require('mini.files').setup({
      mappings = {
        go_in_plus  = 'l',
        -- synchronize = '<C-s>',
      }
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesActionRename",
      callback = function(event)
        local Snacks = require('snacks')
        Snacks.rename.on_rename_file(event.data.from, event.data.to)
      end,
    })

    -- Create splits
    local map_split = function(buf_id, lhs, direction)
      local rhs = function()
        -- Make new window and set it as target
        local cur_target = MiniFiles.get_explorer_state().target_window
        local new_target = vim.api.nvim_win_call(cur_target, function()
          vim.cmd(direction .. ' split')
          return vim.api.nvim_get_current_win()
        end)

        MiniFiles.set_target_window(new_target)

        -- This intentionally doesn't act on file under cursor in favor of
        -- explicit "go in" action (`l` / `L`). To immediately open file,
        -- add appropriate `MiniFiles.go_in()` call instead of this comment.
      end

      -- Adding `desc` will result into `show_help` entries
      local desc = 'Split ' .. direction
      vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id
        -- Tweak keys to your liking
        map_split(buf_id, '<C-s>', 'belowright horizontal')
        map_split(buf_id, '<C-v>', 'belowright vertical')
        map_split(buf_id, '<C-t>', 'tab')
      end,
    })
  end,
  keys = {
    { '<leader>r', function() require('mini.files').open(vim.api.nvim_buf_get_name(0)) end },
    { '<leader>R', function() require('mini.files').open(vim.uv.cwd()) end },
    { "<C-f>", function() require('user.libs.snacks-dirs').find_dirs(function(path) require('mini.files').open(path) end) end, desc = "Find directories" },
  }
}
