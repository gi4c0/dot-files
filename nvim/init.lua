-- Core
require "user.core.options"
require "user.core.keymaps"
require "user.core.globals"
require "user.core.plugins"

require "user.setup-plugins"
require "user.scripts.index"

vim.cmd('source $HOME/.config/nvim/scripts/scripts.vim')
