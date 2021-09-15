require "lsp_signature".setup({
  bind = true,
  handler_opts = {
    border = "single"   -- double, single, shadow, none
  },
  trigger_on_newline = true,
  hint_enable = false,
  doc_lines = 0,
  toggle_key = '<C-s>'
})
