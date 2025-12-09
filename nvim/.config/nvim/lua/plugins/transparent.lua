return {
	"xiyaowong/transparent.nvim",
	lazy = false, -- don’t lazy load, run at startup
	priority = 1000, -- adjust depending on colorscheme
	config = function()
		require("transparent").setup({
			extra_groups = {
				"NormalFloat", -- floating windows
				"NvimTreeNormal", -- nvim-tree background
			},
			exclude_groups = {
				"CursorLine",
				"CursorLineNr",
			},
		})
	end,
}
