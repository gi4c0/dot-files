return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    branch = 'main',
    enabled = true,

    dependencies = {
        -- brew install tree-sitter-cli
        { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
        {
            'eckon/treesitter-current-functions',
            dependencies = { 'nvim-telescope/telescope.nvim' },
            enabled = false,
            keys = {
                {"<leader>fn", ":GetCurrentFunctionsForce telescope<CR>", noremap = true, silent = true, desc = "Functions in current file"}
            }
        },
    },

    init = function()
        local ensureInstalled = {
            "typescript",
            "json",
            "graphql",
            "html",
            "gleam",
            "go",
            "lua",
            "rust",
            "yaml",
            "toml",
            "zig",
            "vim",
            "vimdoc",
            "markdown",
            "markdown_inline"
        }

        local alreadyInstalled = require('nvim-treesitter.config').get_installed()

        local parsersToInstall = vim.iter(ensureInstalled)
        :filter(function(parser)
            return not vim.tbl_contains(alreadyInstalled, parser)
        end)
        :totable()

        require('nvim-treesitter').install(parsersToInstall)
    end,

    config = function()
        -- Delete this file if got error about BufRead *
        -- The actual path for lua parser: /opt/homebrew/Cellar/neovim/0.9.5/lib/nvim/parser/lua.so
        -- local cachePath = "/Users/oleksii/.local/share/nvim/tree-sitter-cache"
        -- vim.opt.runtimepath:append(cachePath)

        require("nvim-treesitter-textobjects").setup {
            select = {
                lookahead = true
            },

            move = { set_jumps = true },
        }

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "*",
            callback = function(args)
                -- pcall safely attempts to start treesitter, ignoring errors if no parser exists
                pcall(vim.treesitter.start, args.buf)
            end,
            desc = "Automatically start Tree-sitter on all filetypes",
        })

        vim.keymap.set({ "n", "x", "o" }, "]f", function()
            require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
        end)

        vim.keymap.set({ "n", "x", "o" }, "]F", function()
            require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
        end)

        vim.keymap.set({ "n", "x", "o" }, "[f", function()
            require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
        end)

        vim.keymap.set({ "n", "x", "o" }, "[F", function()
            require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
        end)

        vim.keymap.set({ "x", "o" }, "af", function()
            require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
        end)
        vim.keymap.set({ "x", "o" }, "if", function()
            require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
        end)

        vim.keymap.set("n", "<leader>pl", function()
            require("nvim-treesitter-textobjects.swap").swap_next "@parameter.inner"
        end)
        vim.keymap.set("n", "<leader>ph", function()
            require("nvim-treesitter-textobjects.swap").swap_previous "@parameter.inner"
        end)
    end,

}
