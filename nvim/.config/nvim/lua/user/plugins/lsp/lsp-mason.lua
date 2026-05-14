return {
  "williamboman/mason.nvim",
  enabled = true,
  tag = "v1.11.0",
  cond = vim.env.COC ~= '1',
  dependencies = {
    {"williamboman/mason-lspconfig.nvim", tag = "v1.32.0"},
    {"WhoIsSethDaniel/mason-tool-installer.nvim"},
  },
  config = function()
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    require("mason-lspconfig").setup({
      ensure_installed = {
        'eslint',
        'vtsls',
        'lua_ls',
        'rust_analyzer',
        'gopls',
        'biome',
        'jsonls',
        'dockerls',
        'html',
        'cssls',
        'html',
        'tailwindcss',
        'emmet_ls',
        'pyright',
        'graphql'
      },

      automatic_installation = true, -- not the same as ensure_installed
    })

    require "mason-tool-installer".setup {
        ensure_installed = {
          'codelldb',
          -- 'tsgo',
          'v-analyzer',
          'js-debug-adapter',
        }
    }
  end,
}
