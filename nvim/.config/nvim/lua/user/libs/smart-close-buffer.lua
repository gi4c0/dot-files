local M = {}

---@return boolean
local function check_dap_windows()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.api.nvim_get_option_value("ft", {buf = buf})

        if ft:match("^dap") then
            return true
        end
    end
    return false
end

M.close_buffer = function ()
    local has_dap_window = check_dap_windows()

    if has_dap_window then
        vim.cmd[[:Kwbd]]
        return
    end

    vim.cmd[[:bdelete]]
end


return M
