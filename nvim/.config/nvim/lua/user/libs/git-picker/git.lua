local M = {}
local H = {}

--Trim function using pattern matching
local function trim(s)
  -- This pattern removes any combination of spaces and asterisks from the start and end.
  return (s:gsub("^[%s%*]*(.-)[%s%*]*$", "%1"))
end

---@return string
H.get_current_file = function()
  local full_path = vim.api.nvim_buf_get_name(0)
  local relative_path = vim.fn.fnamemodify(full_path, ':.')
  return relative_path
end

---@return string[] | nil
M.get_branches = function()
    ---@type string[]
    local branches = {}
    local ok, handle = pcall(io.popen, "git branch")

    if ok and handle then
        for line in handle:lines() do
            table.insert(branches, trim(line))
        end

        handle:close()
        return branches
    else
        -- TODO: doesn't work
        local message = "Failed to execute git branch command"
        vim.notify(message, 'error')
        return
    end
end

---@param branch string
---@return string[]
M.get_files_from_branch = function(branch)
    ---@type string[]
    local files = {}
    local handle = io.popen("git ls-tree -r --name-only " .. branch)
    local current_file = H.get_current_file()

    if handle then
        local first_file

        for git_file in handle:lines() do
            if current_file == git_file then
                first_file = true
            else
                table.insert(files, git_file)
            end
        end

        handle:close()

        if first_file then
            table.insert(files, 1, current_file)
        end
    end

    return files
end

---@class Entries
---@field dirs string[]
---@field files string[]

---@param dir_path string
---@param branch string
---@return Entries
M.get_dir_entries = function(branch, dir_path)
    local files, dirs = {}, {}
    local handle = io.popen("git ls-tree --format '%(objecttype) %(path)' " .. branch .. ' ' .. dir_path)

    if handle then
        for entry in handle:lines() do
            local item = vim.fn.split(entry, ' ')
            local type = item[1]
            local entry_path = item[2]

            if not type or not entry_path then
                error('Cannot parse git output for branch' .. branch ' and dir ' .. dir_path)
            end

            if type == 'blob' then
                table.insert(files, entry_path)
            elseif type == 'tree' then
                table.insert(dirs, entry_path)
            end
        end

        handle:close()
    end

    return { files = files, dirs = dirs }
end

return M
