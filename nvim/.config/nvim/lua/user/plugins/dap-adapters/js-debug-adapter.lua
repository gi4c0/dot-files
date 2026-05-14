local M = {}

M.configure_js_adapter = function()
    local dap = require("dap")
    if not dap.adapters["pwa-node"] then
        require("dap").adapters["pwa-node"] = {
            type = "server",
            host = "localhost",
            port = "${port}",
            executable = {
                command = vim.fn.exepath('js-debug-adapter'),
                args = { "${port}" },
            },
        }
    end

    local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

    local vscode = require("dap.ext.vscode")
    vscode.type_to_filetypes["node"] = js_filetypes
    vscode.type_to_filetypes["pwa-node"] = js_filetypes

    for _, language in ipairs(js_filetypes) do
        if not dap.configurations[language] then
            dap.configurations[language] = {
                {
                    type = "pwa-node",
                    request = "launch",
                    name = "Debug Jest Test",
                    program = "${workspaceFolder}/node_modules/.bin/jest",
                    args = {
                        "--runInBand",
                        "${fileBasenameNoExtension}",
                    },
                    cwd = "${workspaceFolder}",
                    runtimeArgs = {
                        "-r", "tsconfig-paths/register",
                        "-r", "ts-node/register"
                    },
                    console = "integratedTerminal",
                    skipFiles = {"<node_internals>/**"},
                },
                {
                    type = "pwa-node",
                    request = "attach",
                    name = "Attach to port 9229",
                    port = 9229,
                    address = "localhost",
                    cwd = "${workspaceFolder}",
                    skipFiles = {"<node_internals>/**"},
                },
                {
                    type = "pwa-node",
                    request = "attach",
                    name = "Attach",
                    processId = require("dap.utils").pick_process,
                    cwd = "${workspaceFolder}",
                },
                {
                    type = "pwa-node",
                    request = "launch",
                    name = "Launch file",
                    program = "${file}",
                    cwd = "${workspaceFolder}",
                },
            }
        end
    end
end

return M
