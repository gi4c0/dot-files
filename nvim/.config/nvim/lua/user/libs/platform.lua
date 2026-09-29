local M = {}

local uname = vim.loop.os_uname()
M.is_mac = uname.sysname == "Darwin"

local function os_release()
  local f = io.open("/etc/os-release", "r")
  if not f then return {} end
  local result = {}
  for line in f:lines() do
    local key, value = line:match("^(%w+)=(.*)$")
    if key then result[key] = value:gsub('^"(.*)"$', "%1") end
  end
  f:close()
  return result
end

M.is_nixos = not M.is_mac and os_release().ID == "nixos"

--- Resolve a nix-installed binary path, nil if not found
M.nix_bin = function(name)
  local candidates = {
    "/etc/profiles/per-user/alex/bin/" .. name,
    "/run/current-system/sw/bin/" .. name,
  }
  for _, p in ipairs(candidates) do
    if vim.uv.fs_stat(p) then return p end
  end
end

return M
