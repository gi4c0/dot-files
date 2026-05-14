return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'nvim-neotest/nvim-nio',
        {
            "theHamsta/nvim-dap-virtual-text",
            opts = {},
        },
    },

    keys = {
        { '<leader>d<space>', function() require('dap').continue() end, desc = 'Debug: Start/Continue' },
        { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
        { '<leader>dj', function() require('dap').step_over() end, desc = 'Debug: Step Over' },
        { '<leader>dl', function() require('dap').step_into() end, desc = 'Debug: Step Into' },
        { '<leader>dh', function() require('dap').step_out() end, desc = 'Debug: Step Out' },
        { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle Breakpoint' },
        { '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = 'Debug: Set Conditional Breakpoint' },
        { '<leader>dt', function() require('dap').terminate() end, desc = 'Debug: Terminate' },
        { '<leader>dd', function() require('dapui').toggle() end, desc = 'Debug: Toggle UI' },
        { '<leader>de', function() require('dapui').eval(nil, { enter = true }) end, desc = 'Debug: Evaluate Expression', mode = {'n', 'v'} },
        { '<leader>dk', function() require('dapui').eval(nil, { enter = true }) end, desc = 'Debug: Evaluate Expression', mode = {'n', 'v'} },
        { '<leader>dc', function() require('dapui').float_element('console', { position = 'center', width = 150, enter = true, height = 35, title = 'Console' }) end, desc = 'Debug: Console open' },
        { '<leader>ds', function() require('dapui').float_element('scopes', { position = 'center', width = 150, enter = true, height = 35, title = 'Variables' }) end, desc = 'Debug: Scopes open' },
        { '<leader>dr', function() require('dapui').float_element('repl', { position = 'center', width = 150, enter = true, height = 35, title = 'Repl' }) end, desc = 'Repl' },
        { '<leader>df', function() require('dap').focus_frame() end, desc = 'Debug: Focus Frame (current position)' },
    },

    opts = require('user.plugins.dap-adapters.js-debug-adapter').configure_js_adapter,

    config = function ()
        vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

        -- setup dap config by VsCode launch.json file
        local vscode = require("dap.ext.vscode")
        local json = require("plenary.json")

        vscode.json_decode = function(str)
            return vim.json.decode(json.json_strip_comments(str))
        end

        require('dapui').setup({
            layouts = {
                {
                    elements = {
                        -- { id = "scopes", size = 0.7 },
                        -- { id = "watches", size = 0.3 },
                        -- { id = "repl", size = 0.2 },
                        { id = "breakpoints", size = 1 },
                    },
                    size = 40,
                    position = 'right'
                },
                -- {
                    --     elements = {
                        --         'breakpoints',
                        --         'watches',
                        --         'repl'
                        --     },
                        --     size = 10,
                        --     position = 'bottom'
                        -- }
                    }
                })

        local dap, dapui = require("dap"), require("dapui")
        dap.listeners.before.attach.dapui_config = function()
            -- dapui.open()
            vim.notify('Debugger attached')
        end
        -- dap.listeners.before.launch.dapui_config = function()
        --     dapui.open()
        -- end

        -- dap.listeners.before.event_terminated.dapui_config = function()
        --     dapui.close()
        -- end
        -- dap.listeners.before.event_exited.dapui_config = function()
        --     dapui.close()
        -- end
    end
}
