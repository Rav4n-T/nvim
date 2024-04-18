local M = {
	{ -- "jiangmiao/auto-pairs",
		"m4xshen/autoclose.nvim",
		event = "InsertEnter",
		config = function()
			require("autoclose").setup({
				keys = {
					-- ["<"] = { escape = true, close = true, pair = "<>", disabled_filetypes = { "cpp" } },
				},
				options = {
					disable_when_touch = true,
					touch_regex = "[%w(%[%{]",
					pair_spaces = true,
				},
			})
		end,
	},
	{
		"utilyre/sentiment.nvim",
		version = "*",
		event = "VeryLazy", -- keep for lazy loading
		opts = {
			-- config
		},
		init = function()
			-- `matchparen.vim` needs to be disabled manually in case of lazy loading
			vim.g.loaded_matchparen = 1
		end,
	},
}
return M
