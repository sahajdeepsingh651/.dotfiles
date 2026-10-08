return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
        modes = {
            search = { enabled = false }, -- don't override / search
        },
    },
    keys = {
        { "<leader>j", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash Jump" },
        { "<leader>J", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,         desc = "Flash Treesitter" },
        { "<leader>jr", mode = "o",              function() require("flash").remote() end,              desc = "Remote Flash" },
        { "<leader>jR", mode = { "o", "x" },     function() require("flash").treesitter_search() end,  desc = "Treesitter Search" },
        { "<c-s>",      mode = { "c" },          function() require("flash").toggle() end,             desc = "Toggle Flash Search" },
    },
}
