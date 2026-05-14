local M = {}
local H = {}

local file_helper = require('user.libs.file-helper')

local BRANCH_CACHE_PATH = vim.fn.expand("~/.local/share/nvim/recent_git_branches.json")
local FILES_CACHE_PATH = vim.fn.expand("~/.local/share/nvim/recent_files.json")

---@class BranchFile
---@field name string
---@field idx integer

---@type string
local last_cwd_branch = ''
---@type string
local last_branch
---@type string
local last_file
---@type string
local current_file

---@type table<string, string[]>
local branches_by_cwd = {}
---@type table<string, string[]>
local files_by_branch = {}

---@param file string
M.save_current_file = function(file)
    current_file = file
end

---@param file string
M.save_file_to_cache = function(file)
    last_file = file

    if not files_by_branch[last_cwd_branch] then
        files_by_branch[last_cwd_branch] = {}
    end

    local files = files_by_branch[last_cwd_branch]
    local existing_index = vim.fn.index(files, file)

    if existing_index == 0 then -- already on the top of the list
        return
    end

    if existing_index > 0 then
        table.remove(files, existing_index + 1)
    end

    table.insert(files, 1, file)
end

---@param project_cwd string
---@param branch string
M.save_branch_to_state = function (project_cwd, branch)
    last_cwd_branch = project_cwd .. '__' .. branch
    last_branch = branch

    if not branches_by_cwd[project_cwd] then
      branches_by_cwd[project_cwd] = {}
    end

    local branches = branches_by_cwd[project_cwd]

    ---@type integer
    local existing_branch_index = vim.fn.index(branches, branch)

    if existing_branch_index == 0 then -- already on the top of the list
        return
    end

    if existing_branch_index > 0 then
        table.remove(branches, existing_branch_index + 1)
    end

    table.insert(branches, 1, branch)
end

H.load_cache = function()
    if vim.fn.filewritable(BRANCH_CACHE_PATH) ~= 1 then
        H.save_file({}, BRANCH_CACHE_PATH)
        return
    end

    if vim.fn.filewritable(FILES_CACHE_PATH) ~= 1 then
        H.save_file({}, FILES_CACHE_PATH)
        return
    end

    branches_by_cwd = file_helper.read_file(BRANCH_CACHE_PATH)
    files_by_branch = file_helper.read_file(FILES_CACHE_PATH)
end

H.load_cache()

---@param new string[]
---@param cache string[]
---@return string[]
H.merge = function(new, cache)
    for cache_index, cache_item in ipairs(cache) do
        local cache_item_index_in_new = vim.fn.index(new, cache_item)

        if cache_item_index_in_new == -1 then -- item from cache was not found in the fresh branches
            table.remove(cache, cache_index)
            goto continue
        end

        if cache_item_index_in_new + 1 == cache_index then
            goto continue
        end

        table.remove(new, cache_item_index_in_new + 1)
        table.insert(new, cache_index, cache_item)

        ::continue::
    end

    return new
end

---@param cwd string
---@param all_branches string[]
---@return string[]
M.merge_branches_with_cache = function(cwd, all_branches)
    local branches = branches_by_cwd[cwd]

    if not branches then
      return all_branches
    end

    return H.merge(all_branches, branches)
end

---@param all_files string[]
---@return string[]
M.merge_files_with_cache = function(all_files)
    local cache_files = files_by_branch[last_cwd_branch]

    if not cache_files or #cache_files == 0 then
      return all_files
    end

    local merged = H.merge(all_files, cache_files)
    local current_file_index = vim.fn.index(merged, current_file)

    if current_file_index ~= -1 then
        table.remove(merged, current_file_index + 1)
        table.insert(merged, 1, current_file)
    end

    return merged
end

vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        file_helper.write_file(branches_by_cwd, BRANCH_CACHE_PATH)
        file_helper.write_file(files_by_branch, FILES_CACHE_PATH)
    end
})

---@return string, string
M.get_last_used_branch_and_file = function()
    return last_branch, last_file
end

---@param file string
M.set_last_visited_file = function(file)
    last_file = file
end

return M
