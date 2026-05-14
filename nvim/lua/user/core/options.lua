vim.opt.hidden  =  true
vim.opt.keymap = "russian-jcukenwin"          -- Russion language
vim.opt.iminsert = 0
vim.opt.imsearch = 0
vim.opt.showcmd = true               -- Show commands
vim.opt.laststatus = 2          -- influences when the last window will have a status line (2 - always)
vim.opt.autowrite = true             -- Automatically write before running commands
vim.opt.autoread = true              -- Reload files changed outside vim
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true            -- Better aligning with '<','>'
vim.opt.smarttab = true              -- Makes tabbing smarter will realize you have 2 vs 4
vim.opt.expandtab = true             -- Converts tabs to spaces
vim.opt.autoindent = true            -- Good auto indent
vim.opt.smartindent = true           -- Makes indenting smart
vim.opt.number = true -- Relative numbers
vim.opt.relativenumber = true
vim.opt.scrolloff = 8           -- Start scrolling when we're 8 lines away from margins
vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 15
vim.opt.hlsearch = true              -- Hightlighting search result
vim.opt.incsearch = true             -- Highlight everything right after typing
vim.opt.ignorecase = true            -- Ingore case while search
vim.opt.showmatch = true             -- Show matching brackets
vim.opt.history = 200           -- History amount of commands to keep in memory
vim.opt.cmdheight = 1           -- Better display for messages
vim.opt.updatetime = 300        -- Smaller updatetime for CursorHold & CursorHoldI
vim.opt.timeoutlen = 1000       -- By default timeoutlen is 1000 ms
vim.opt.signcolumn = 'yes'        -- Always show signcolumns
vim.opt.background = 'dark'       -- for the dark version
vim.opt.wrap = false                -- Display long lines
vim.opt.pumheight = 10          -- Makes popup menu smaller
-- vim.opt.fileencoding = 'utf-8'    -- The encoding written to file
-- vim.opt.mouse = 'a'               -- Enable your mouse
vim.opt.splitbelow = true            -- Horizontal splits will automatically be below
vim.opt.splitright = true            -- Vertical splits will automatically be to the right
-- vim.opt.t_Co = 256              -- Support 256 colors
vim.opt.cursorline = true            -- Enable highlighting of the current line
vim.opt.backup = false              -- This is recommended by coc
vim.opt.termguicolors = true
vim.opt.writebackup = true         -- This is recommended by coc
vim.opt.clipboard = 'unnamedplus' -- Copy paste between vim and everything else
vim.opt.showmode = false            -- Get rid of 'INSERT/NORMAL/VISUAL' status
-- vim.opt.colorcolumn = '140'       -- Visualize max allowed line length by column
vim.opt.swapfile = false                        -- creates a swapfile
vim.opt.iskeyword:append("-")
vim.opt.shortmess:append("c")
vim.diagnostic.config({ virtual_text = false })

vim.filetype.add({
  extension = {
    ['http'] = 'http',
  },
})

-- Enable persistent undo
vim.opt.undofile = true

-- Set the directory where undo history will be stored
-- This uses a standard Neovim data path (~/.local/share/nvim/undo on Linux/macOS)
local undo_dir = vim.fn.stdpath("data") .. "/undo"
vim.opt.undodir = undo_dir


-- Create the directory if it doesn't exist
if vim.fn.isdirectory(undo_dir) == 0 then
    vim.fn.mkdir(undo_dir, "p")
end
