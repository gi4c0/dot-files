return {
    'pteroctopus/faster.nvim',
    enabled = true,
    config = {
      behaviours = {
        bigfile = {
          extra_patterns = {
            { pattern = "*.json", filesize = 0.5 },
            { pattern = "*.ts", filesize = 9999 }
          }
        }
      }
    }
}
