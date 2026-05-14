return {
    'echasnovski/mini.nvim',
    version = false,
    enabled = true,
    lazy = false,
    config = function ()
        -- require('mini.completion').setup()

        require('mini.files').setup({
            mappings = {
                go_in_plus  = 'l',
                synchronize = '<C-s>',
            },
            windows = {
                preview = true,
                width_preview = 35
            }
        })

        require('mini.pick').setup {
            mappings = {
                move_down  = '<C-j>',
                move_up    = '<C-k>',
            }
        }

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
                MiniFiles.go_in()
                MiniFiles.close()
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
                -- map_split(buf_id, '<C-s>', 'belowright horizontal')
                map_split(buf_id, '<C-v>', 'belowright vertical')
                map_split(buf_id, '<C-t>', 'tab')
            end,
        })

        vim.api.nvim_create_autocmd("User", {
            pattern = "MiniFilesWindowUpdate",
            callback = function(ev)
                local state = MiniFiles.get_explorer_state() or {}

                local win_ids = vim.tbl_map(function(t)
                    return t.win_id
                end, state.windows or {})

                local function idx(win_id)
                    for i, id in ipairs(win_ids) do
                        if id == win_id then return i end
                    end
                end

                local this_win_idx = idx(ev.data.win_id)
                local focused_win_idx = idx(vim.api.nvim_get_current_win())

                -- this_win_idx can be nil sometimes when opening fresh minifiles
                if this_win_idx and focused_win_idx then
                    -- idx_offset is 0 for the currently focused window
                    local idx_offset = this_win_idx - focused_win_idx

                    -- the width of windows based on their distance from the center
                    -- i.e. center window is 60, then next over is 20, then the rest are 10.
                    -- Can use more resolution if you want like { 60, 30, 20, 15, 10, 5 }
                    local widths = { 60, 40, 35 }

                    local i = math.abs(idx_offset) + 1 -- because lua is 1-based lol
                    local win_config = vim.api.nvim_win_get_config(ev.data.win_id)
                    win_config.width = i <= #widths and widths[i] or widths[#widths]

                    local offset = 0
                    for j = 1, math.abs(idx_offset) do
                        local w = widths[j] or widths[#widths]
                        -- and an extra +2 each step to account for the border width
                        local _offset = 0.5*(w + win_config.width) + 2
                        if idx_offset > 0 then
                            offset = offset + _offset
                        elseif idx_offset < 0 then
                            offset = offset - _offset
                        end
                    end

                    win_config.height = idx_offset == 0 and 25 or 20
                    win_config.row = math.floor(0.5*(vim.o.lines - win_config.height))
                    win_config.col = math.floor(0.5*(vim.o.columns - win_config.width) + offset)
                    vim.api.nvim_win_set_config(ev.data.win_id, win_config)
                end
            end
        })
    end,
    keys = {
        { '<leader>r', function() require('mini.files').open(vim.api.nvim_buf_get_name(0)) end },
        { '<leader>R', function() require('mini.files').open(vim.uv.cwd()) end },
        { "<C-f>", function() require('user.libs.snacks-dirs').find_dirs(function(path) require('mini.files').open(path) end) end, desc = "Find directories" },
    }
}
