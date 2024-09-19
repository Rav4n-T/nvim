return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		config = function()
			local map = vim.keymap.set
			local fzflua = require("fzf-lua")
			local actions = fzflua.actions
			fzflua.setup({
				actions = {
					files = {
						["enter"] = actions.file_edit,
					},
				},
			})

			map("n", "<leader>fi", fzflua.builtin, { desc = "fzf builtin" })

			map("n", "<leader>ff", fzflua.files, { desc = "fzf file" })
			map("n", "<leader>fb", fzflua.buffers, { desc = "fzf buffers" })
			map("n", "<leader>fd", fzflua.diagnostics_document, { desc = "fzf diagnostics" })
			map("n", "<leader>fw", fzflua.live_grep, { desc = "fzf live grep" })
			map("n", "<leader>fn", fzflua.lgrep_curbuf, { desc = "fzf live grep current buffer" })
		end,
	},
}
