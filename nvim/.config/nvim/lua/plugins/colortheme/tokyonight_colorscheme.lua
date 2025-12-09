return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        style = "moon", -- "storm", "moon", "night", "day"
        transparent = false, -- if true, disables background
        terminal_colors = true,
        styles = {
            comments = { italic = true },
            keywords = { italic = true },
            functions = {},
            variables = {},
            sidebars = "dark", -- style for sidebars
            floats = "dark",   -- style for floating windows
        },
        sidebars = { "qf", "help" }, -- set darker on specific sidebars
        day_brightness = 0.3,  -- adjusts brightness when using style = "day"
        hide_inactive_statusline = false,
        dim_inactive = false,
        lualine_bold = false,
    },
    config = function(_, opts)
        require("tokyonight").setup(opts)
        vim.cmd("colorscheme tokyonight")
    end,
}
