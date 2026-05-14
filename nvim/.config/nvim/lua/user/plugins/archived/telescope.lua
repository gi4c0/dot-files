return {
  'nvim-telescope/telescope.nvim',
  lazy = false,
  enabled = false,

  dependencies = {
    {
      'nvim-telescope/telescope-file-browser.nvim',
      build = 'brew install fd', -- Needed for faster directories loading. Alternative to find
    },
    {
      "danielfalk/smart-open.nvim",
      -- branch = "0.2.x",
      dependencies = {
        "kkharji/sqlite.lua",
        -- Only required if using match_algorithm fzf
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        -- Optional.  If installed, native fzy will be used when match_algorithm is fzy
        { "nvim-telescope/telescope-fzy-native.nvim" },
      },

      config = function()
        require("telescope").load_extension("smart_open")
      end,

      keys = {
        -- {'<C-Space>', ':Telescope smart_open<CR>', silent = true, desc = "Recent files"}
      }
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- enabled = false,
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
    },
    {'molecule-man/telescope-menufacture'},
    {'nvim-telescope/telescope-live-grep-args.nvim'},
    {
      'aaronhallaert/advanced-git-search.nvim',
      dependencies = {
        'tpope/vim-rhubarb'
      }
    },
  },

  config = function()
    local actions = require('telescope.actions')
    local open_with_trouble = require("trouble.sources.telescope").open
    local fb_actions = require("telescope._extensions.file_browser.actions")
    local smart_open_actions = require("smart-open.actions")

    require("telescope").setup {
      defaults = {
        respect_gitignore = false,
        file_ignore_patterns = {"^.git/", "dist/"},
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-t>"] = open_with_trouble,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-p>"] = require('telescope.actions.layout').toggle_preview,
          },
          n = {
            ["<C-t>"] = open_with_trouble,
          }
        },

      },
      pickers = {
        find_files = {
          previewer = false,
          path_display = { "absolute" }
        },
        buffers = {
          sort_lastused = true,
          previewer = false,
          mappings = {
            i = {
              ["<c-d>"] = actions.delete_buffer,
            },
            n = {
              ["<c-d>"] = actions.delete_buffer,
            }
          }
        }
      },
      extensions = {
          smart_open = {
            previewer = false,
            cwd_only = true,
            mappings = {
              i = {
                ["<C-w>"] = function ()
                  vim.api.nvim_input "<c-s-w>"
                end,
                ["<C-d>"] = smart_open_actions.delete_buffer
              },
            },
          },
        -- advanced_git_search = {
          --   -- See Config
          -- },
          fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "ignore_case",        -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
          file_browser = {
            respect_gitignore = false,
            -- file_ignore_patterns = {".git/*"},
            previewer = true,
            -- initial_mode = "normal",
            grouped = true,
            hidden = true,
            select_buffer = true,
            sorting_strategy = "ascending",
            display_stat = false,
            layout_strategy = "horizontal",
            layout_config = {
              anchor = "CENTER",
              height = 0.75,
              preview_cutoff = 40,
              prompt_position = "top",
              width = .8
            },
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {
              n = {
                h = fb_actions.goto_parent_dir,
                l = actions.select_default, -- action for going into directories and opening files
              },
              i = {
                ['<C-h>'] = fb_actions.goto_parent_dir,
                ['<C-l>'] = actions.select_default, -- action for going into directories and opening files
              },
            },
          }
        }
      }

      require("telescope").load_extension "fzf"
      require("telescope").load_extension "file_browser"
      require("telescope").load_extension "menufacture"
      require("telescope").load_extension "live_grep_args"
      require("telescope").load_extension "smart_open"
    end,

    keys = {
      -- {"<C-p>", "<cmd>lua require'telescope.builtin'.find_files({ hidden = true })<cr>",noremap = true, silent = true},
      -- {"<leader>/", ":lua require('telescope').extensions.menufacture.live_grep()<CR>",noremap = true, silent = true, desc = "Telescope live grep"}, -- use <C-^> to open a menu
      -- {"<leader>/", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", noremap = true, silent = true, desc = "Telescope grep ('query' -g **/path/*file*)"},
      -- {"<C-Space>", "<cmd>lua require('telescope.builtin').buffers()<cr>",noremap = true, silent = true},
      -- {'<C-p>', ':Telescope smart_open<CR>', silent = true, desc = "Recent files"},
      -- {"<leader>fr", "<cmd>lua require('telescope.builtin').oldfiles()<cr>",noremap = true, silent = true},

      -- {"<leader>hh", ":Telescope help_tags<CR>", silent = true, desc = "Seach on help tags"},
      -- {"<C-f>", ":Telescope file_browser files=false initial_mode=insert respect_gitignore=true<CR>", noremap = true, silent = true, desc = "Search by folder"},
      -- { "gr", ":Telescope lsp_references<cr>",noremap = true, silent = true, desc = "Show LSP references" },
      -- {"gt", "<cmd>Telescope lsp_type_definitions<CR>", silent = true, noremap = true, desc = "Show LSP type definitions"},

      -- {"<leader>r", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", noremap = true, silent = true, desc = "File browser (from file)"},
      -- {"<leader>R", ":Telescope file_browser<CR>", noremap = true, silent = true, desc = "File browser (from root)"},

      -- {"<leader>li", "<cmd>Telescope lsp_implementations<CR>", desc = "Show LSP Implementations"},
      -- {"<leader>el", "<cmd>Telescope diagnostics bufnr=0<CR>", desc = "Show buffer diagnostics"},
    },

  }

