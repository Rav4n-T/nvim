return {
	{
		"mistweaverco/kulala.nvim",
		ft = { "http" },
		opts = {
			-- split direction
			-- possible values: "vertical", "horizontal"
			split_direction = "horizontal",
			debug = true,
		},
		config = function(_, opts)
			local map = vim.keymap.set
			local kulala = require("kulala")
			kulala.setup(opts)

			map("n", "<leader>hr", kulala.run, { desc = "runs the current request" })
			map("n", "<leader>ha", kulala.run_all, { desc = "runs all request in current buffer" })
			map("n", "<leader>hl", kulala.replay, { desc = "replays the last run request" })
			map("n", "<leader>hi", kulala.inspect, { desc = "inspect the current request" })
			map("n", "<leader>hs", kulala.show_stats, { desc = "shows the statistics of the last run request" })
			map("n", "<leader>ht", kulala.toggle_view, { desc = "toggles between the body and headers view" })
			map("n", "<leader>hq", kulala.close, { desc = "close the kulala window" })
		end,
	},
}
