return {
	"catppuccin/nvim",
	event = "VeryLazy",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			transparent_background = true,
			styles = {
				comments = { "italic" },
				conditionals = { "italic" },
				-- loops = { "bold" },
				functions = { "italic" },
				-- keywords = {},
				-- strings = { "italic" },
				variables = { "italic" },
				-- numbers = {},
				-- booleans = { "bold" },
				-- properties = { "italic" },
				-- types = { "bold" },
				operators = {},
			},
		})
	end,
}
