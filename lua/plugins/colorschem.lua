local M = {
  -- {
  -- 	"ellisonleao/gruvbox.nvim",
  -- 	priority = 1000,
  -- 	opts = {
  -- 		undercurl = false,
  -- 		underline = true,
  -- 		bold = true,
  -- 		italic = {
  -- 			strings = false,
  -- 			comments = false,
  -- 			operators = false,
  -- 			folds = false,
  -- 		},
  -- 		strikethrough = true,
  -- 		invert_selection = false,
  -- 		invert_signs = false,
  -- 		invert_tabline = false,
  -- 		invert_intend_guides = false,
  -- 		inverse = true, -- invert background for search, diffs, statuslines and errors
  -- 		contrast = "hard", -- can be "hard", "soft" or empty string
  -- 		palette_overrides = {},
  -- 		overrides = {},
  -- 		dim_inactive = false,
  -- 		transparent_mode = true,
  -- 	},
  -- },
  {
    "sainnhe/everforest",
    priority = 1000,
    config = function()
      -- highlight diagnostic virtual text or line
      vim.g.everforest_diagnostic_virtual_text = "colored"
      vim.g.everforest_diagnostic_line_highlight = 1
      vim.g.everforest_enable_italic = 1
      vim.g.everforest_transparent_background = 1
      vim.g.everforest_float_style = "dim"
    end,
  },
}
return M
