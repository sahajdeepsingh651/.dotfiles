return {
	{
		"pocco81/high-str.nvim",

		cmd = {
			"HSHighlight",
			"HSRmHighlight",
			"HSExport",
			"HSImport",
		},

		config = function()
			require("high-str").setup({
				verbosity = 0,
				saving_path = vim.fn.stdpath("data") .. "/highstr/",

				highlight_colors = {
					color_1 = { "#111111", "#4DA6FF" }, -- BLUE
					color_2 = { "#111111", "#00FFAA" },
					color_3 = { "#111111", "#FFD700" },
				},
			})

			-- auto restore
			vim.api.nvim_create_autocmd("BufReadPost", {
				callback = function()
					vim.cmd("silent! HSImport")
				end,
			})

			-- SHORT COMMANDS (fixed)
			vim.api.nvim_create_user_command("HH", function()
				vim.cmd("HSHighlight 2") -- BLUE (correct)
			end, {})

			vim.api.nvim_create_user_command("HR", function()
				vim.cmd("HSRmHighlight")
			end, {})

			vim.api.nvim_create_user_command("HRA", function()
				vim.cmd("HSRmHighlight rm_all")
			end, {})

			vim.api.nvim_create_user_command("HX", function()
				vim.cmd("HSExport")
			end, {})

			vim.api.nvim_create_user_command("HI", function()
				vim.cmd("HSImport")
			end, {})
		end,
	},
}
