local M = {}

---@param name string
---@return string
M.extract_entry_name = function(name)
    return name:match("([^/]+)$")
end

---@param path string
---@return string
M.extract_dir = function(path)
    local trimmed = path:gsub("/$", "")
    return trimmed:match("(.*/)")
end


---@return string
M.get_current_relative_file_path = function ()
    local full_file_path = vim.fn.expand('%:p')
    local cwd, err = vim.uv.cwd()

    if not cwd or err then
        vim.notify("Error getting cwd: " .. err)
        return ''
    end

    local relative = vim.fn.fnamemodify(full_file_path, ':s?' .. vim.fn.escape(cwd, '?') .. '/??')
    return relative
end


return M
