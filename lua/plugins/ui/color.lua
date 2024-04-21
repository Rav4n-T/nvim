local M = {
	{
		"brenoprata10/nvim-highlight-colors",
		config = function()
			require("nvim-highlight-colors").setup({
				-- @usage 'background'|'foreground'|'virtual'
				render = "virtual",
				virtual_symbol = "",
				enable_named_colors = true,
				enable_tailwind = true,
				custom_colors = {
					-- label property will be used as a pattern initially(string.gmatch), therefore you need to escape the special characters by yourself with %
					-- { label = "%-%-theme%-font%-color", color = "#fff" },
					-- { label = "%-%-theme%-background%-color", color = "#23222f" },
					-- { label = "%-%-theme%-primary%-color", color = "#0f1219" },
					-- { label = "%-%-theme%-secondary%-color", color = "#5a5d64" },
					-- { label = "%-%-theme%-contrast%-color", color = "#fff" },
					-- { label = "%-%-theme%-accent%-color", color = "#55678e" },
				},
			})
		end,
	},
}

return M
