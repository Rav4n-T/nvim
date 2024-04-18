local M = {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		opts = {
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = true,
				comments = true,
				operators = true,
				folds = true,
			},
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = false,
			inverse = false, -- invert background for search, diffs, statuslines and errors
			contrast = "hard", -- can be "hard", "soft" or empty string
			palette_overrides = {},
			overrides = {},
			dim_inactive = false,
			transparent_mode = true,
		},
	},
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("everforest").setup({
				background = "medium", -- soft | medium | hard
				transparent_background_level = 0.8,
				italics = true,
				disable_italic_comments = false,
				sign_column_background = "none",
				ui_contrast = "high", -- high | low
				dim_inactive_windows = true,
				diagnostic_text_highlight = true,
				diagnostic_virtual_text = "coloured", -- grey | coloured
				diagnostic_line_highlight = true,
				spell_foreground = false,
				show_eob = true,
				float_style = "dim", -- bright | dim
				on_highlights = function(hl, palette)
					hl.DiagnosticError = { fg = palette.none, bg = palette.none, sp = palette.red }
					hl.DiagnosticWarn = { fg = palette.none, bg = palette.none, sp = palette.yellow }
					hl.DiagnosticInfo = { fg = palette.none, bg = palette.none, sp = palette.blue }
					hl.DiagnosticHint = { fg = palette.none, bg = palette.none, sp = palette.green }
				end,
				colours_override = function(_) end,
			})
		end,
	},
}
return M
