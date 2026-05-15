return {
    {
         'Mofiqul/vscode.nvim' ,
         config = function ()
             vim.o.background = 'dark'
         end
    },
    {
        'navarasu/onedark.nvim',
        enabled = true,
        init = function()
            require('onedark').setup {
                style = 'warmer',
                transparent = true,
                code_style = {
                    comments = 'italic',
                    keywords = 'bold',
                    -- functions = 'none',
                    -- strings = 'none',
                    -- variables = 'none'
                },
                lualine = {
                    transparent = true, -- lualine center bar transparency
                },
            }

            require('onedark').load()
        end
    },
    {
        "olimorris/onedarkpro.nvim",
        priority = 1000, -- Ensure it loads first
    },

    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "storm",
                transparent = true,
                -- on_highlights = function(hl, c)
                --     local prompt = "#2d3149"
                --     hl.TelescopeNormal = {
                --         bg = c.bg_dark,
                --         fg = c.fg_dark,
                --     }
                --     hl.TelescopeBorder = {
                --         bg = c.bg_dark,
                --         fg = c.bg_dark,
                --     }
                --     hl.TelescopePromptNormal = {
                --         bg = prompt,
                --     }
                --     hl.TelescopePromptBorder = {
                --         bg = prompt,
                --         fg = prompt,
                --     }
                --     hl.TelescopePromptTitle = {
                --         bg = prompt,
                --         fg = prompt,
                --     }
                --     hl.TelescopePreviewTitle = {
                --         bg = c.bg_dark,
                --         fg = c.bg_dark,
                --     }
                --     hl.TelescopeResultsTitle = {
                --         bg = c.bg_dark,
                --         fg = c.bg_dark,
                --     }
                -- end,
            })

            vim.cmd[[colorscheme tokyonight]]
        end
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function ()
            require("catppuccin").setup {
                flavour = "macchiato", -- latte, frappe, macchiato, mocha
                transparent_background = true,

                integrations = {
                    lualine = {
                        enabled = false,
                        -- lualine color overrides in the following hierarchy: Catppuccin Flavor -> Mode -> Lualine Section
                        -- The Catppuccin flavor entry can be any Catpuccin flavor or "all" to apply to all flavors
                        -- The flavor entry can be either a table or a function which consumes the current Catppuccin palette, just like custom_highlights and color_overrides
                        all = function(colors)
                            ---@type CtpIntegrationLualineOverride
                            return {
                                -- Specifying a normal-mode status line override for section a's background and b's foreground to use lavender like the main Catppuccin theme
                                normal = {
                                    a = { bg = colors.lavender, gui = "italic" },
                                    b = { fg = colors.lavender },
                                }
                            }
                        end,
                        -- A macchiato-specific override, which takes priority over 'all'. Also using the direct table syntax instead of function in case you do not rely on dynamic palette colors
                        macchiato = {
                            normal = {
                                a = { bg = "#abcdef" },

                            }
                        },
                    },
                    mini = {
                        enabled = true,
                        indentscope_color = "", -- catppuccin color (eg. `lavender`) Default: text
                    },
                    blink_cmp = {
                        style = 'bordered',
                    },
                    telescope = {
                        enabled = false,
                    }
                }
            }

            -- vim.cmd.colorscheme "catppuccin-nvim"
        end
    },
    {
        'AlexvZyl/nordic.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('nordic').setup({
                transparent = {
                    bg = true,
                    float = false,
                }
            })

            -- require('nordic').load()
        end
    },
    {
        'rebelot/kanagawa.nvim',
        config = function()
            require('kanagawa').setup({
                transparent = true
            })

            -- vim.cmd("colorscheme kanagawa-wave")
        end
    }
}
