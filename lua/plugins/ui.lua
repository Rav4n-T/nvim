return {
	{
		"echasnovski/mini.indentscope",
		event = { "BufEnter" },
		opts = {
			symbol = "╎",
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
		config = function(_, opts)
			require("mini.indentscope").setup(opts)
		end,
	},
	{
		"gen740/SmoothCursor.nvim",
		event = "CursorMoved",
		opts = {
			fancy = {
				enable = true,
				head = { cursor = "", texthl = "SmoothCursor", linehl = nil },
			},
		},
	},
}
