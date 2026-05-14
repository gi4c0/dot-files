local M = {}

M.find = function ()
    local word = vim.fn.expand('<cword>')
    -- run ripgrep in vimgrep format, no colors, fixed-string search
    local cmd = table.concat({
        'rg',
        '--vimgrep',
        '--color=never',
        '-F', vim.fn.shellescape(word),
        '-g', vim.fn.shellescape('*.resolver.ts'),
    }, ' ')
    local results = vim.fn.systemlist(cmd)

    if vim.v.shell_error ~= 0 or #results == 0 then
        vim.notify('rg: no matches for "'..word..'"', vim.log.levels.WARN)
        return
    end

    -- parse the first line of the form "path/to/file.ts:123:45:match…"
    local file, line_number = results[1]:match('^(.-):(%d+):%d+:')
    if not file or not line_number then
        vim.notify('rg: could not parse output', vim.log.levels.ERROR)
        return
    end

    -- open the file and jump to that line
    vim.cmd(('edit +%d %s'):format(tonumber(line_number), file))

end

return M
