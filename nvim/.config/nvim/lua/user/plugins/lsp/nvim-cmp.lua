return {
  -- 'hrsh7th/nvim-cmp',
  'iguanacucumber/magazine.nvim',
  event = "InsertEnter",
  name = "nvim-cmp",
  cond = vim.env.COC ~= '1',
  enabled = false,
  lazy = false,

  dependencies = {
    { "iguanacucumber/mag-nvim-lsp", name = "cmp-nvim-lsp", opts = {} },
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          { path = "snacks.nvim", words = { "Snacks" } },
        },
      },
    },
    { "iguanacucumber/mag-nvim-lua", name = "cmp-nvim-lua" },
    { "iguanacucumber/mag-buffer", name = "cmp-buffer" },
    { "iguanacucumber/mag-cmdline", name = "cmp-cmdline" },
    { "https://codeberg.org/FelipeLema/cmp-async-path" },

    -- { "hrsh7th/cmp-buffer" }, -- source for text in buffer
    { "petertriho/cmp-git" },
    -- { "hrsh7th/cmp-path" }, -- source for file system paths
    { "saadparwaiz1/cmp_luasnip", }, -- for autocompletion
    { "onsails/lspkind.nvim" }, -- vs-code like pictograms

    {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      enabled = true,
      config = function()
        local autopairs = require("nvim-autopairs")
        local Rule = require("nvim-autopairs.rule")
        local cond = require("nvim-autopairs.conds")
        local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }

        autopairs.setup{}

        autopairs.add_rules {
          Rule("<", ">"):with_pair(cond.before_regex("%a+")):with_move(function(opts) return opts.char == ">" end),
          Rule("|", "|"):with_pair(cond.before_regex("%(+")):with_move(function(opts) return opts.char == "|" end),
          Rule(' ', ' ')
          -- Pair will only occur if the conditional function returns true
          :with_pair(function(opts)
            -- We are checking if we are inserting a space in (), [], or {}
            local pair = opts.line:sub(opts.col - 1, opts.col)
            return vim.tbl_contains({
              brackets[1][1] .. brackets[1][2],
              brackets[2][1] .. brackets[2][2],
              brackets[3][1] .. brackets[3][2]
            }, pair)
          end)
          :with_move(cond.none())
          :with_cr(cond.none())
          -- We only want to delete the pair of spaces when the cursor is as such: ( | )
          :with_del(function(opts)
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local context = opts.line:sub(col - 1, col + 2)
            return vim.tbl_contains({
              brackets[1][1] .. '  ' .. brackets[1][2],
              brackets[2][1] .. '  ' .. brackets[2][2],
              brackets[3][1] .. '  ' .. brackets[3][2]
            }, context)
          end)
        }

        -- For each pair of brackets we will add another rule
        for _, bracket in pairs(brackets) do
          autopairs.add_rules {
            -- Each of these rules is for a pair with left-side '( ' and right-side ' )' for each bracket type
            Rule(bracket[1] .. ' ', ' ' .. bracket[2])
            :with_pair(cond.none())
            :with_move(function(opts) return opts.char == bracket[2] end)
            :with_del(cond.none())
            :use_key(bracket[2])
            -- Removes the trailing whitespace that can occur without this
            :replace_map_cr(function(_) return '<C-c>2xi<CR><C-c>O' end)
          }
        end
      end
    }
  },

  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- If you want insert `(` after select function or method item
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = {
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({select = false}),

        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),

        ["<C-l>"] = cmp.mapping(function(fallback)
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
      },
      -- sources for autocompletion
      preselect = cmp.PreselectMode.None,
      sources = cmp.config.sources({
        {
          name = "nvim_lsp",
          entry_filter = function(entry, ctx)
            return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
          end
        },
        {
          name = 'lazydev',
          group_index = 0,
        },
        -- { name = "luasnip" }, -- snippets
        { name = "path" }, -- file system paths
        { name = "buffer" }, -- text within current buffer
      }),
      -- configure lspkind for vs-code like pictograms in completion menu
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
          -- Cut additional info about autocompleted items
          before = function (_entry, vim_item)
            if (vim_item.menu ~= nil and vim.fn.strcharlen(vim_item.menu) > 45) then
              vim_item.menu = vim.fn.strcharpart(vim_item.menu, 1, 42) .. "..."
            end

            return vim_item
          end
        }),
      },
    })

    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
        { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
      }, {
        { name = 'buffer' },
      })
    })

    cmp.setup.filetype({ 'sql' }, {
      sources = {
        { name = "vim-dadbod-completion" },
        { name = "buffer" }
      }
    })

    require("cmp_git").setup()
  end
}
