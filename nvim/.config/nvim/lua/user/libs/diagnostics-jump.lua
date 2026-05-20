local M = {}

M.goto_priority_diagnostic = function (direction)
  -- Define the order of severity priority you want
  local severities = {
    vim.diagnostic.severity.ERROR,
    vim.diagnostic.severity.WARN,
    vim.diagnostic.severity.INFO,
    vim.diagnostic.severity.HINT
  }

  for _, severity in ipairs(severities) do
    -- Query the current buffer (0) for diagnostics of this specific severity
    local diagnostics = vim.diagnostic.get(0, { severity = severity })
    -- If we find any, restrict our jump to this severity and exit the function
    if #diagnostics > 0 then
      if direction == "next" then
        vim.diagnostic.jump { count = 1, float = true, severity = severity }
      else
        vim.diagnostic.jump { count = -1, float = true, severity = severity }
      end
      return
    end
  end

  -- Fallback if the buffer is entirely clean (prevents errors)
  if direction == "next" then
    vim.diagnostic.jump { count = 1, float = true }
  else
    vim.diagnostic.jump { count = -1, float = true }
  end
end

return M
