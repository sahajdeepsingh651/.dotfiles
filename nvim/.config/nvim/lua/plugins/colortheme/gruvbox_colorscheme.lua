return {
	"ellisonleao/gruvbox.nvim",
	lazy = false, -- load on startup
	priority = 1000, -- make sure it loads before other plugins
	config = function()
		require("gruvbox").setup({
			terminal_colors = true, -- add gruvbox colors to :terminal
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = true,
				emphasis = true,
				comments = true,
				operators = false,
				folds = true,
			},
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = false,
			inverse = true, -- invert background for search, diffs, statuslines
			contrast = "", -- can be "hard", "soft" or empty string
			palette_overrides = {},
			overrides = {},
			dim_inactive = false,
			transparent_mode = false, -- set true if using transparent.nvim
		})
		vim.o.background = "dark" -- or "light" if you prefer
		vim.cmd("colorscheme gruvbox")
	end,
}
