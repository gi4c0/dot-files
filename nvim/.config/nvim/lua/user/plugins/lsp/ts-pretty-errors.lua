return {
  "enochchau/nvim-pretty-ts-errors",
  build = "npm install",
  keys = {
      {'<leader>et', function() require("nvim-pretty-ts-errors").show_line_diagnostics() end, desc = "TypeScript Error Diagnostics"}
  }
}
