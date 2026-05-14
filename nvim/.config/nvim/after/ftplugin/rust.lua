local buf = vim.api.nvim_get_current_buf()
local opts =  { silent = true, buffer = buf, noremap = true };
local keymap = vim.keymap

-- Need to leave it here because it replaces default LSP codeAction and crashes in non rust environment
-- keymap.set("n", "<leader>ca", function() vim.cmd.RustLsp('codeAction') end, opts)
