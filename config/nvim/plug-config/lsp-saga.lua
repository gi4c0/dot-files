local saga = require('lspsaga')
saga.init_lsp_saga()

vim.api.nvim_set_keymap('n', '<leader>aw', ':Lspsaga code_action<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>aw', ':<C-U>Lspsaga range_code_action<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>mrr', ':Lspsaga rename<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'K', ':Lspsaga hover_doc<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-b>', '<cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(1)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-f>', '<cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(-1)<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-j>', ':Lspsaga diagnostic_jump_next<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', ':Lspsaga diagnostic_jump_prev<CR>', { noremap = true, silent = true })
