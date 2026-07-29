-- Inform tmux when Neovim enters/leaves
local tmux_group = vim.api.nvim_create_augroup("TmuxNavigate", { clear = true })

local function set_tmux_var(val)
  if vim.env.TMUX then
    vim.system({ "tmux", "set-option", "-p", "@is_vim", val })
  end
end

vim.api.nvim_create_autocmd({ "VimEnter", "VimResume" }, {
  group = tmux_group,
  callback = function() set_tmux_var("1") end,
})

vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
  group = tmux_group,
  callback = function() set_tmux_var("0") end,
})

-- Set variable immediately if Neovim is already running
set_tmux_var("1")
