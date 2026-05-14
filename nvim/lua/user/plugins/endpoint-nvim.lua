return {
  "zerochae/endpoint.nvim",
  enabled = true,
  tag = "v2.7.0",
  -- branch = "fix/64",
  dependencies = {
    "folke/snacks.nvim",            -- For snacks picker
  },
  cmd = { "Endpoint", "EndpointRefresh" },
  config = function()
    require("endpoint").setup {
        picker = {
            type = 'snacks'
        }
    }
  end,

  keys = {
      { '<leader>se', ':Endpoint<CR>', silent = true, desc = 'Find Endpoints' },
      { '<leader>sEp', ':Endpoint Post<CR>', silent = true, desc = 'Find Endpoints POST' },
      { '<leader>sEP', ':Endpoint Put<CR>', silent = true, desc = 'Find Endpoints PUT' },
      { '<leader>sEr', ':EndpointRefresh<CR>', silent = true, desc = 'Find Endpoints PUT' },
  }
}
