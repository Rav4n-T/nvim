return {
	{
		"askfiy/http-client.nvim",
		ft = { "http" },
		config = function()
			local map = vim.keymap.set
			local http = require("http-client")

			http.setup({})

			map("n", "<leader>hr", "<cmd>HttpClient sendRequest<cr>", { desc = "runs the current request" })
		end,
	},
}
