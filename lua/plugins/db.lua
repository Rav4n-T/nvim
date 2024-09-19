return {
	{
		"kndndrj/nvim-dbee",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		event = "VeryLazy",
		-- ft = { "go" },
		build = function()
			require("dbee").install()
		end,
		config = function()
			local dbee = require("dbee")
			local map = vim.keymap.set

			map("n", "<leader>bb", dbee.open, { desc = "Open Dbee" })
			map("n", "<leader>bc", dbee.close, { desc = "Close Dbee" })
			map("n", "<leader>bt", dbee.toggle, { desc = "Toggle Dbee" })

			dbee.setup({
				editor = {
					mappings = {
						{ key = "<leader>be", mode = "n", action = "run_file", desc = "dbee run selection" },
						{ key = "<leader>be", mode = "v", action = "run_selection", desc = "dbee run all file" },
					},
				},
			})
		end,
	},
}
