return {
	{
		"neanias/everforest-nvim",
		event = "VeryLazy",
		priority = 1000, -- make sure to load this before all the other start plugins
		-- Optional; default configuration will be used if setup isn't called.
		config = function()
			require("everforest").setup({
				on_highlights = function(hl, palette)
					hl.DiagnosticError = { fg = palette.none, bg = palette.none, sp = palette.red }
					hl.DiagnosticWarn = { fg = palette.none, bg = palette.none, sp = palette.yellow }
					hl.DiagnosticInfo = { fg = palette.none, bg = palette.none, sp = palette.blue }
					hl.DiagnosticHint = { fg = palette.none, bg = palette.none, sp = palette.green }
					hl.TSBoolean = { fg = palette.purple, bg = palette.none, bold = true }
				end,
				background = "soft",
				transparent_background_level = 2,
				italics = true,
				disable_italic_comments = false,
				sign_column_background = "none",
				ui_contrast = "high",
				dim_inactive_windows = false,
				diagnostic_text_highlight = false,
				diagnostic_virtual_text = "coloured",
				diagnostic_line_highlight = true,
				spell_foreground = true,
				show_eob = true,
			})
		end,
	},
	{
		"catppuccin/nvim",
		event = "VeryLazy",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				background = {
					light = "latte",
					dark = "macchiato",
				},
				transparent_background = true,
				show_end_of_buffer = false,
				integration_default = false,
			})
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		event = "VeryLazy",
		priority = 1000,
		config = true,
		opts = {
			terminal_colors = true, -- add neovim terminal colors
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
			inverse = false, -- invert background for search, diffs, statuslines and errors
			contrast = "", -- can be "hard", "soft" or empty string
			palette_overrides = {},
			overrides = {},
			dim_inactive = false,
			transparent_mode = true,
		},
	},
}
