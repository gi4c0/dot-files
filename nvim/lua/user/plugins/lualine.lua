local function full_path()
    local path = vim.fn.expand('%')

    -- Handle empty buffers (like a newly opened, unnamed file)
    if path == '' then
        path = '[No Name]'
    else
        -- Apply your custom path logic. 
        -- The "or path" fallback prevents errors if the file is in the root directory.
        path = '/' .. (path:match("([^/]+/[^/]+)$") or path)
    end

    -- Append the modified indicator if the buffer has unsaved changes
    if vim.bo.modified then
        path = path .. ' [+]'
    end

    -- Optional: Append a readonly indicator
    if vim.bo.readonly or not vim.bo.modifiable then
        path = path .. ' [-]'
    end

    return path
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
       'nvim-tree/nvim-web-devicons',
  },
  opts = {
    options = {
      icons_enabled = true,
      -- theme = 'tokyonight',
      theme = 'catppuccin-nvim',
      component_separators = {'', ''},
      section_separators = {'', ''},
      disabled_filetypes = {}
    },
    sections = {
      lualine_a = {'branch'},
      lualine_b = {'diagnostics'},
      lualine_c = {full_path},
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    tabline = {},
    extensions = {}
  }
}
