return {
    "folke/snacks.nvim",
    priority=1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        -- words = {},
        lazygit = {},
        image = {},
        picker = {
            filter = {
                cwd = true
            },
            layout = {
                layout ={
                    width = 0.85
                }
            },
            formatters = {
                file = {
                    filename_first = true,
                    truncate = 150
                }
            },
            win = {
                input = {
                    keys = {
                        ["<C-p>"] = { "toggle_preview", mode = { "i", "n" } },
                    }
                }
            }
        },
        notifier = {},
        gitbrowse = {},
        indent = {},
        -- scratch = {
        --     win = {
        --         keys = {
        --             ['q'] = false,
        --             ['Q'] = 'close'
        --         }
        --     }
        -- },
        health = {},
        bigfile = {
            notify = false,
            size = 100 * 15 * 1024 * 1024, -- 1.5MB * 100
            line_length = 500, -- average line length (useful for minified files)
        }
    },
    keys = {
        -- { "<C-p>", function() Snacks.picker.smart({ layout = { preview = false, layout = { width = 0.5 } } }) end, desc = "Smart Find Files" },
        -- { '<C-p>', function() require('user.libs.snacks-fff').fff() end, desc = "Snacks fff" },
        { "<leader>K", function() Snacks.picker.smart({ layout = { preview = false, layout = { width = 0.5 } }, cwd = "./kulala" }) end, desc = "Kalula picker" },
        { "<C-Space>", function() Snacks.picker.buffers({ layout = { preview = false, layout = { width = 0.5 } }, sort_lastused = true, nofile = false, current = false }) end, desc = "Buffers" },
        { "<leader>F", function() Snacks.explorer({ layout = { preset = "vertical", layout = { width = 0.5 } }, auto_close = true }) end, desc = "File Explorer" },
        { "<leader>fr", function() Snacks.picker.recent() end, desc = "Files Recent" },
        -- { "<leader>R", function() Snacks.explorer({ layout = { preset = "vertical" }, auto_close = true, ignored = true, hidden = true }) end, desc = "File Explorer with hidden and ingored" },
        { "<leader>*", function() Snacks.picker.grep_word() end, desc = "Grep word" },
        { "<leader>/", function() Snacks.picker.grep({ hidden = true }) end, desc = "Grep" },
        { "<leader>fn", function() Snacks.picker.lsp_symbols({ filter = { default = { "Method" } } }) end, desc = "Show functions and methods" },
        { "<leader>fs", function() Snacks.picker.lsp_symbols() end, desc = "Show LSP Symblos" },
        { "gr", function() Snacks.picker.lsp_references() end, desc = "Go to lsp References" },
        { "gt", function() Snacks.picker.lsp_references() end, desc = "Go to Type definitions" },
        { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
        { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
        { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
        { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },

        { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Show notifier history" },
        { "<leader>T", function() Snacks.picker.colorschemes() end, desc = "Pick colorscheme" },
        -- { "<leader>y", function() Snacks.picker.cliphist() end, desc = "Clipboard history" },

        { "<leader>bs",  function() Snacks.scratch({ layout = { false } }) end, desc = "Toggle Scratch Buffer" },
        { "<leader>bS",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
        -- Disable because highlight works slow on big project
        -- { "]r",  function() Snacks.words.jump(1, true) end, desc = "Jump reference forward" },
        -- { "[r",  function() Snacks.words.jump(-1, true) end, desc = "Jump reference backward" },
        { "<leader>gg",  function() Snacks.lazygit() end, desc = "Lazy git" },

        { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
        { '<leader>gc', function() require('user.libs.git-picker').pick_branch_and_file() end },

        { '<leader>ti', ':lua Snacks.picker.lines()<CR> it( ', silent = true, desc = "show Test (it) tests" },
    },
}

