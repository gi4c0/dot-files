return {
    "reybits/scratch.nvim",
    lazy = true,
    keys = {
        { "<leader>bs", "<cmd>ScratchToggle<cr>", desc = "Toggle Scratch Buffer" },
        { "<leader>bS", "<cmd>ScratchIssues<cr>", desc = "Toggle Scratch Task List" },
        { "<leader>bl", "<cmd>ScratchIssues<cr>", desc = "Toggle Scratch Task List" },
        { "<leader>bt", "<cmd>ScratchTask<cr>", desc = "New Scratch Task" },
    },
    cmd = {
        "ScratchToggle",
        "ScratchIssues",
        "ScratchTask",
    },
    opts = {},
}
