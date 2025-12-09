return {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    config = function()
        -- must come BEFORE colorscheme!
        vim.g.everforest_enable_terminal = true
        vim.opt.termguicolors = true

        -- now load colorscheme
        vim.cmd.colorscheme("everforest")

        -- override entire 0–15 ANSI palette to white
        local white = "#ffffff"
        for i = 0, 15 do
            vim.g["terminal_color" .. i] = white
        end

        -- ensure it reapplies on colorscheme reload
        vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = "everforest",
            callback = function()
                for i = 0, 15 do
                    vim.g["terminal_color" .. i] = white
                end
            end,
        })
    end,
}
