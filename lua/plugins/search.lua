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
				winopts = { preview = { default = "bat" } },
				grep = {
					rg_opts = "--column --line-number --hidden --no-heading --color=always --smart-case --max-columns=4096 --glob '!/.git/*' -e",
					actions = {
						["ctrl-h"] = { actions.toggle_ignore },
					},
				},
				files = {
					actions = {
						["ctrl-g"] = false,
						["ctrl-h"] = { actions.toggle_ignore },
					},
				},
				manpages = { previewer = "man_native" },
				helptags = { previewer = "help_native" },
				lsp = { code_actions = { previewer = "codeaction_native" } },
				tags = { previewer = "bat" },
				btags = { previewer = "bat" },
				actions = {
					files = {
						["enter"] = actions.file_edit,
						["ctrl-s"] = actions.file_split,
						["ctrl-v"] = actions.file_vsplit,
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
