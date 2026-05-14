return {
    'kevinhwang91/rnvimr',
    setup = function()
        vim.g.rnvimr_enable_ex = true
        vim.g.rnvimr_enable_picker = true
        vim.g.rnvimr_enable_picker = true
        vim.g.rnvimr_hide_gitignore = false

        vim.g.rnvimr_action = {

            ['<C-v>'] = 'NvimEdit vsplit',
            ['<C-s>'] = 'NvimEdit split'
        }

        vim.cmd [[
            " Customize the initial layout
            let g:rnvimr_layout = {
                \ 'relative': 'editor',
                \ 'width': float2nr(round(0.8 * &columns)),
                \ 'height': float2nr(round(0.8 * &lines)),
                \ 'col': float2nr(round(0.15 * &columns)),
                \ 'row': float2nr(round(0.15 * &lines)),
                \ 'style': 'minimal'
                \ }
        ]]
    end,
    keys = {
        {'<leader>r', function() vim.cmd 'RnvimrToggle' end, silent = true, desc = 'Ranger'}
    }
}
