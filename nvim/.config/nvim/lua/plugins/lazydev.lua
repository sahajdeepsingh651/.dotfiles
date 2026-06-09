return {
  {
    "pocco81/high-str.nvim",
    config = function()
      require("high-str").setup({
        highlight_colors = {
          color_1 = {"#e5c07b", "smart"},
          color_2 = {"#7FFFD4", "smart"},
          color_3 = {"#0000FF", "smart"},
        },
      })
    end,
  },
}
