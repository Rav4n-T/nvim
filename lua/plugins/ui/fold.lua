local M = {
	{
		"anuvyklack/pretty-fold.nvim",
		event = "BufEnter",
		config = function()
			require("pretty-fold").setup({
				keep_indentation = false,
				fill_char = "━",
				sections = {
					left = {
						"━ ",
						function()
							return string.rep("*", vim.v.foldlevel)
						end,
						" ━┫",
						"content",
						"┣",
					},
					right = {
						"┫ ",
						"number_of_folded_lines",
						": ",
						"percentage",
						" ┣━━",
					},
				},
			})
		end,
	},
	{
		"anuvyklack/fold-preview.nvim",
		event = "BufEnter",
		dependencies = {
			"anuvyklack/keymap-amend.nvim",
		},
		config = function()
			require("fold-preview").setup({
				-- Your configuration goes here.
			})
		end,
	},
}
return M
