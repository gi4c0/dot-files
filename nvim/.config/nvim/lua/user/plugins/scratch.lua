return {
    "reybits/scratch.nvim",
    lazy = true,
    keys = {
        { "<leader>Bs", "<cmd>ScratchToggle<cr>", desc = "Toggle Scratch Buffer" },
        { "<leader>Bi", "<cmd>ScratchIssues<cr>", desc = "Toggle Scratch Issues" },
        { "<leader>Bt", "<cmd>ScratchTask<cr>", desc = "New Scratch Task" },
    },
    cmd = {
        "ScratchToggle",
        "ScratchIssues",
        "ScratchTask",
    },
    opts = {},
}
