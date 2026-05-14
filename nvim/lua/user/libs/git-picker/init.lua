local M = {}
local Snacks = require("snacks")
local state = require('user.libs.git-picker.state')
local git = require('user.libs.git-picker.git')
local util = require('user.libs.git-picker.util')
local explorer = require('user.libs.git-picker.explorer')

local layout = {
  layout = {
    box = "horizontal",
    width = 0.5,
    height = 0.5,
    {
      box = "vertical",
      border = "rounded",
      title = "Find branch",
      { win = "input", height = 1, border = "bottom" },
      { win = "list", border = "none" },
    },
  },
}

---@param branch string
---@param files table
local function open_file_from_branch(branch, files)
    local merged_files = state.merge_files_with_cache(files)
    local items = {}

    for i, item in ipairs(merged_files) do
        table.insert(items, { idx = i, score = 1, filename = item, text = item })
    end

    Snacks.picker.pick({
        items = items,
        formatters = {
            file = {
                filename_first = false,
            }
        },
        format = function(item, _)
            local ret = {}
            local a = Snacks.picker.util.align
            local icon, icon_hl = Snacks.util.icon(item.filename)

            ret[#ret + 1] = { a(icon, 3), icon_hl }
            ret[#ret + 1] = { " " }
            ret[#ret + 1] = { a(item.filename, 20) }

            return ret
        end,
        layout = layout,
        confirm = function(picker, item)
            picker:close()
            state.save_file_to_cache(item.filename)
            vim.cmd(':Gvsplit ' .. branch .. ':' .. item.filename)
            explorer.set_key_bindings(vim.api.nvim_get_current_buf())
        end,
        preview = nil,
    })

end

M.pick_branch_and_file = function()
  local branches = git.get_branches()
  if not branches then return end

  -- save current file to move it to the top later
  state.save_current_file(util.get_current_relative_file_path())

  local cwd, err = vim.uv.cwd()

  if not cwd or err then
      vim.notify("Error getting cwd: " .. err)
      return
  end

  local merged_with_cache = state.merge_branches_with_cache(cwd, branches)
  local items = {}

  for i, item in ipairs(merged_with_cache) do
    table.insert(items, { idx = i, score = 1, branch = item, text = item })
  end

  Snacks.picker.pick({
    items = items,
    formatters = {
      file = {
        filename_first = false,
      }
    },
    layout = layout,
    format = function(item, _)
      local ret = {}
      local a = Snacks.picker.util.align
      local icon, icon_hl = Snacks.util.icon('git', 'filetype')

      ret[#ret + 1] = { a(icon, 3), icon_hl }
      ret[#ret + 1] = { " " }
      ret[#ret + 1] = { a(item.branch, 20) }

      return ret
    end,
    confirm = function(picker, item)
      picker:close()

      state.save_branch_to_state(cwd, item.branch)
      local files = git.get_files_from_branch(item.branch)

      if #files > 0 then
        open_file_from_branch(item.branch, files)
      end
    end,
    preview = nil,
  })
end

M.open_explorer = explorer.open_explorer

M.code_diff = function()
  local branches = git.get_branches()
  if not branches then return end
end

return M
