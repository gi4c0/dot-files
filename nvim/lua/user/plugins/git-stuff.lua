local layout = {
  layout = {
    box = "horizontal",
    width = 0.5,
    height = 0.5,
    {
      box = "vertical",
      border = "rounded",
      title = "Find branch",
      { win = "input", height = 1, border = "bottom" },
      { win = "list", border = "none" },
    },
  },
}

local function pick_branch_for_code_diff ()
    local branches = {}
    local ok, handle = pcall(io.popen, 'git branch --sort=-creatordate --format="%(refname:short)"')

    if ok and handle then
        for line in handle:lines() do
            table.insert(branches, line)
        end

        handle:close()
    else
        local message = "Failed to execute git branch command"
        vim.notify(message, 'error')
        return
    end

    local items = {}
    table.insert(items, { idx = 1, score = 1, branch = '', text = 'HEAD' })

    for i, item in ipairs(branches) do
        table.insert(items, { idx = i + 1, score = 1, branch = item, text = item })
    end

    Snacks.picker.pick({
        items = items,
        formatters = {
            file = {
                filename_first = false,
            }
        },
        layout = layout,
        format = function(item, _)
            local ret = {}
            local a = Snacks.picker.util.align
            local icon, icon_hl = Snacks.util.icon('git', 'filetype')

            ret[#ret + 1] = { a(icon, 3), icon_hl }
            ret[#ret + 1] = { " " }
            ret[#ret + 1] = { a(item.text, 20) }

            return ret
        end,

        confirm = function(picker, item)
            picker:close()
            vim.cmd('CodeDiff ' .. item.branch)
        end,
        preview = nil,
    })
end

return {
    {
        "esmuellert/codediff.nvim",
        cmd = "CodeDiff",
        lazy = false,
        keys = {
            {'<leader>gD', pick_branch_for_code_diff, desc = 'CodeDiff with branch'}
        },
        config = function()
            local gitlab = require('user.libs.gitlab')
            require('codediff').setup {
                explorer = {
                    enabled = false
                }
            }

            vim.api.nvim_create_user_command(
                'MR',
                function(opts) gitlab.show_mr(opts.args) end,
                { nargs = 1 }
            )
        end
    },

    {
        'lewis6991/gitsigns.nvim',
        config = true,
        lazy = false,
        keys = {
            {"<leader>gd", ":Gitsigns preview_hunk<CR>", desc = "Difference hunk preview", silent = true},
            {'<leader>gB', function() require('gitsigns').toggle_current_line_blame() end},
            {
                ']g',
                function()
                    if vim.wo.diff then
                        vim.cmd.normal({']c', bang = true})
                    else
                        require('gitsigns').nav_hunk('next')
                    end
                end,
                silent = true,
                desc = "Next git chunk"
            },

            {
                '[g',
                function()
                    if vim.wo.diff then
                        vim.cmd.normal({'[c', bang = true})
                    else
                        require('gitsigns').nav_hunk('prev')
                    end
                end,
                silent = true,
                desc = "Next git chunk"
            }
        }
    },

    {
        'tpope/vim-fugitive',
        enabled = true,
        lazy = false,
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "git",
                callback = function()
                    vim.opt_local.foldmethod = "syntax" -- Need this to automatically fold file changes in git object
                end
            })
        end,
        dependencies = {
            { -- pretty git log
                "rbong/vim-flog",
                lazy = true,
                cmd = { "Flog", "Flogsplit", "Floggit" },
                keys = {
                    {'<leader>gf', ':Flog -path=', noremap = true, silent = true, desc = "Git flog for path" },
                    {"<leader>gl", ":Flogsplit -path=%<CR>", noremap = true, silent = true, desc = "Git log of current file" },
                    {"<leader>gL", ":Flogsplit<CR>", noremap = true, silent = true, desc = "Git log of repository file" },
                }
            },
        },

        keys = {
            {"<leader>gs", ":vertical :Git<CR>", noremap = true, silent = true, desc = "Git status" },
            -- {"<leader>gS", ":vertical :Git<CR><C-w>o", noremap = true, silent = true, desc = "Git status (full screen)" },
            {"<leader>gb", ":Git blame<CR>", noremap = true, silent = true, desc = "Git blame" },
            -- {"<leader>gc", ":Gvsplit :%<left><left>", noremap = true, silent = true, desc = "Show git file on given commit/branch" },
            {">", "zo", desc = "Open fold", ft="git" },
            {"<", "zc", desc = "Close fold", ft="git" },
            {"<TAB>", "za", desc = "Toggle fold", ft="git" },
        }
    },

    {
        'fredehoey/tardis.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = true,
    }

}
