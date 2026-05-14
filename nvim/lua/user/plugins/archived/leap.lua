return {
    'ggandor/leap.nvim',
    enabled = false,
    config = function()
        require('leap')
    end,
    keys = {
        {'<C-/>', '/', mode = {'n', 'x', 'o'}, noremap = true},
        {'/', '<Plug>(leap-forward)', mode = {'n', 'x', 'o'}},
        {'?', '<Plug>(leap-backward)', mode = {'n', 'x', 'o'}},
    }
}
