local function copy_hover_type()
    local params = vim.lsp.util.make_position_params(0, 'utf-8')
    
    vim.lsp.buf_request(0, "textDocument/hover", params, function(err, result, ctx, config)
        if err then
            vim.notify("LSP error: " .. err.message, vim.log.levels.ERROR)
            return
        end
        
        if not result or not result.contents then
            return
        end

        local contents = result.contents
        local hover_str = ""

        if type(contents) == "string" then
            hover_str = contents
        elseif type(contents) == "table" and contents.value then
            hover_str = contents.value
        elseif type(contents) == "table" then
            for _, val in ipairs(contents) do
                if type(val) == "string" then
                    hover_str = hover_str .. val .. "\n"
                elseif type(val) == "table" and val.value then
                    hover_str = hover_str .. val.value .. "\n"
                end
            end
        end

        if hover_str == "" then
            vim.notify("Empty hover info", vim.log.levels.WARN)
            return
        end

        local signature = string.match(hover_str, "```[a-zA-Z0-9_]*\n(.-)\n```")
        if not signature then
            signature = hover_str
        end

        signature = vim.trim(signature)

        -- --- NEW CLEANUP STEPS ---
        
        -- 1. Remove LSP context tags like "(parameter) ", "(property) ", "(local) "
        signature = signature:gsub("^%(.-%)%s*", "")
        
        -- 2. Strip out keywords like "let ", "const ", or "var "
        signature = signature:gsub("^let%s+", "")
        signature = signature:gsub("^const%s+", "")
        signature = signature:gsub("^var%s+", "")

        -- 3. Extract just the type after the colon (e.g., turns "achievement: Type" into "Type")
        -- We make sure we don't accidentally do this to function definitions.
        if not signature:match("^function") and not signature:match("^class") then
            local after_colon = signature:match(":%s*(.*)")
            if after_colon then
                signature = after_colon
            end
        end

        -- Clean up any remaining whitespace that might have been left behind
        signature = vim.trim(signature)
        
        -- -------------------------

        vim.fn.setreg('+', signature)
        vim.fn.setreg('"', signature)
        
        vim.notify("Copied type:\n" .. signature, vim.log.levels.INFO)
    end)
end

vim.keymap.set('n', '<leader>ct', copy_hover_type, { desc = "Copy variable type to clipboard" })
