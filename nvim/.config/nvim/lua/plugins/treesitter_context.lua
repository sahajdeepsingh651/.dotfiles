return {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
        enable = true,
        max_lines = 3,
        min_window_height = 20,
        trim_scope = "outer",
        mode = "cursor",
    },
    keys = {
        { "<leader>tc", "<cmd>TSContextToggle<cr>", desc = "Toggle Treesitter Context" },
    },
}
