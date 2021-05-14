require'nvim-treesitter.configs'.setup {
  ensure_installed = { "typescript", "json", "go", "lua", "rust", "yaml" },     -- one of "all", "language", or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
