local util = require('user.libs.git-picker.util')
local git = require('user.libs.git-picker.git')
local state = require('user.libs.git-picker.state')
local mini_icon = require('mini.icons')

local M = {}
local H = {}

---@class FloatWindowOpts
---@field width integer
---@field height integer

---@param input FloatWindowOpts | nil
---@return integer, integer
H.create_float_window = function(input)
    input = input or {}
    -- Create a scratch buffer that is unlisted and won't be saved.
    local buf = vim.api.nvim_create_buf(false, true)

    -- Define the dimensions for the floating window.
    local width = input.width or 70
    local height = input.height or 30

    -- Calculate the centered position.
    -- Note: vim.o.lines includes the command-line, so you might need to adjust the row offset.
    local row = math.floor((vim.o.lines - height) / 2 - 1)
    local col = math.floor((vim.o.columns - width) / 2)

    -- Set window options.
    local opts = {
        style = "minimal",     -- Removes borders and other UI elements.
        relative = "editor",   -- Position relative to the entire editor.
        width = width,
        height = height,
        row = row,
        col = col,
    }

    -- Open the floating window.
    local win = vim.api.nvim_open_win(buf, true, opts)

    -- Set buffer options to make it non-editable and ephemeral.
    vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
    vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })  -- Remove buffer when window is closed.
    vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })   -- Prevent the buffer from being associated with a file.
    vim.api.nvim_set_option_value("cursorline", true, { win = win })   -- Prevent the buffer from being associated with a file.
    vim.api.nvim_set_option_value('filetype', 'git_explorer', { buf = buf })

    vim.keymap.set('n', 'q', function() vim.api.nvim_win_close(win, true) end, { buffer = buf })

    vim.keymap.set('n', 'h', function()
        local branch = state.get_last_used_branch_and_file()
        local prev_dir = util.extract_dir(H.current_path) or ''
        H.fill_with_content(buf, win, branch, prev_dir)
    end, { buffer = buf })

    vim.keymap.set('n', 'l', function()
        local selected = vim.fn.trim(vim.api.nvim_get_current_line())
        local branch = state.get_last_used_branch_and_file()

        if H.path_by_dir[selected] then
            H.fill_with_content(buf, win, branch, H.path_by_dir[selected])
            return
        end

        if H.path_by_file[selected] then
            vim.api.nvim_win_close(win, true)
            vim.cmd(':Gedit ' .. branch .. ':' .. H.path_by_file[selected])
            M.set_key_bindings(vim.api.nvim_get_current_buf())
            state.set_last_visited_file(H.path_by_file[selected])
            return
        end

        error("Couldn't find path for entry: " .. selected)
    end, { buffer = buf })

    return buf, win
end

M.open_explorer = function()
    local branch, file = state.get_last_used_branch_and_file()

    if not branch or not file then
        vim.notify('No file was previously picked', "info")
        return M.pick_branch_and_file()
    end

    local dir = util.extract_dir(file)

    local buf, win = H.create_float_window()
    H.fill_with_content(buf, win, branch, dir, file)
end

H.path_by_dir = {}
H.path_by_file = {}
H.current_path = {}

---@param buf integer
---@param win integer
---@param branch string
---@param dir string
---@param current_file string | nil
H.fill_with_content = function(buf, win, branch, dir, current_file)
    H.current_path = dir
    local entries = git.get_dir_entries(branch, dir)
    ---@type string[]
    local combined = {}

    local dir_icon = mini_icon.get('directory', '')

    for _, item in ipairs(entries.dirs) do
        local truncated = dir_icon .. ' ' .. util.extract_entry_name(item)
        H.path_by_dir[truncated] = item .. '/'
        table.insert(combined, truncated)
    end

    ---@type integer
    local select_file_line

    for file_index, item in ipairs(entries.files) do
        local file_icon = mini_icon.get('file', item)
        local truncated = file_icon .. ' ' .. util.extract_entry_name(item)
        H.path_by_file[truncated] = item
        table.insert(combined, truncated)

        if current_file == item then
            select_file_line = file_index
        end
    end

    vim.api.nvim_set_option_value('modifiable', true, { buf = buf })
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, combined)
    vim.api.nvim_set_option_value('modifiable', false, { buf = buf })

    local select_column = select_file_line or 1
    vim.api.nvim_win_set_cursor(win, {select_column, 5})
end

---@param buf integer
M.set_key_bindings = function(buf)
    vim.keymap.set('n', '<leader>r', M.open_explorer, { buffer = buf })
    vim.keymap.set('n', 'q', function() vim.cmd(':q') end, { buffer = buf })
end

return M
