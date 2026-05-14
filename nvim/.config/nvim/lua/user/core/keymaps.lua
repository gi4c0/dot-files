local options = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", options)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
keymap("n", "<Down>", ":resize -8<CR>", options)
keymap("n", "<Up>", ":resize +8<CR>", options)
keymap("n", "<Left>", ":vertical resize -8<CR>", options)
keymap("n", "<Right>", ":vertical resize +8<CR>", options)
keymap("n", "<C-s>", ":w<cr>", options)

keymap('n', 'cI', '^ciw', options)

-- Close window with Q
vim.keymap.set("n", "Q", require('user.libs.smart-close-buffer').close_buffer, options)
keymap("n", "<leader>sc", ":nohlsearch<CR>", { noremap = true, silent = true, desc = "Clear" })

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", options)
keymap("v", ">", ">gv", options)

keymap("n", "[b", ":bprevious<CR>", options)
keymap("n", "]b", ":bnext<CR>", options)

keymap("n", "]t", ":tabnext<CR>", options)
keymap("n", "[t", ":tabprevious<CR>", options)

keymap('i', '<c-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', options)

keymap('n', '<leader>bD', ':Bonly<CR>', { noremap = true, silent = true, desc = "Delete all buffers except for current" })

keymap('n', '<leader>tO', ':tabonly<CR>', { noremap = true, silent = true, desc = "Delete all tabs except for current" })
keymap('n', '<leader>tn', ':tabedit<CR>', { noremap = true, silent = true, desc = "New tab" })
keymap('n', '<leader>tc', ':tabedit<CR>', { noremap = true, silent = true, desc = "New tab" })

vim.keymap.set({'n'}, '<leader>td', ':tabclose<cr>', { noremap = true, silent = true, desc = "Close tab" })

vim.keymap.set('n', '<leader>fy', function()
    local fname = vim.fn.expand('%:t')
    vim.fn.setreg('+', fname)
    print('📋 File name copied: ' .. fname)
end, { desc = 'Copy current file name to clipboard' })

vim.keymap.set('n', 'gR', require('user.libs.find-resolver').find, { desc = "Find resolver" })

vim.keymap.set('t', '<ESC><ESC>', '<C-\\><C-n>')

-- Move highlighted block up/down in Visual mode
vim.keymap.set('v', '<C-j>', ":m '>+1<CR>gv=gv", { desc = 'Move block down', silent = true })
vim.keymap.set('v', '<C-k>', ":m '<-2<CR>gv=gv", { desc = 'Move block up', silent = true })

vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
