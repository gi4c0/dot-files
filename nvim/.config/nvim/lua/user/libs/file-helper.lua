local M = {}

---@param file_path string
M.read_file = function (file_path)
    local file = io.open(file_path, "r")

    if file then
        local json_string = file:read("*a")
        file:close()

        local ok, result = pcall(vim.fn.json_decode, json_string)
        if not ok then return {} end
        return result
    else
        return {}
    end
end

---@param file_path string
M.write_file = function(data, file_path)
    local json_content = vim.fn.json_encode(data)
    local file, err = io.open(file_path, "w")

    if file then
        file:write(json_content)
    else
        vim.notify("Error: couldn't to write cache file. " .. err, "error")
    end
end

return M
