return {
	{
		"nvim-telescope/telescope.nvim",
		-- cmd = "Telescope",
		event = "VeryLazy",
		version = false, -- telescope did only one release, so use HEAD for now
		dependencies = {
			{ "nvim-telescope/telescope-project.nvim" },
			{ "nvim-lua/plenary.nvim" },
		},
		opts = function()
			local actions = require("telescope.actions")
			local themes = require("telescope.themes")
			return {
				defaults = themes.get_dropdown({
					file_ignore_patterns = { "node_modules", ".obsidian", ".terraform", "%.jpg", "%.png" },
					scroll_strategy = "cycle",
					mappings = {
						i = {
							["<C-q>"] = actions.close,
						},
					},
					borderchars = {
						{ "─", "│", "─", "│", "┌", "┐", "┘", "└" },
						prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
						results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
						preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					},
					width = 0.8,
					previewer = false,
					prompt_title = false,
				}),
				-- layout_config = {
				-- 	horizontal = {
				-- 		preview_cutoff = 100,
				-- 		preview_width = 0.5,
				-- 	},
				-- },
				pickers = {
					find_files = {
						find_command = { "fd", "-tf" },
					},
					buffers = {
						initial_mode = "insert",
					},
					grep_string = {
						initial_mode = "normal",
					},
				},
				extensions = {
					project = {
						theme = "dropdown",
						base_dirs = {
							{ "~/Workspaces" },
							{ "~/Projectes" },
						},
						hidden_files = true,
						sync_with_nvim_tree = true,
					},
				},
			}
		end,
		config = function(_, opts)
			local map = vim.keymap.set
			local tel = require("telescope")
			tel.setup(opts)
			tel.load_extension("project")
			tel.load_extension("noice")

			map("n", "<leader>bl", "<cmd>Telescope buffers<cr>", { desc = "Pick Buffer" })

			map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Pick File" })
			map("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "Pick Grep live" })

			map(
				"n",
				"<leader>pb",
				"<cmd>Telescope lsp_workspace_symbols<cr>",
				{ desc = "Pick Workspaces symbols list" }
			)
			map("n", "<leader>pc", "<cmd>Telescope commands<cr>", { desc = "Pick commands list" })
			map("n", "<leader>pe", "<cmd>Telescope file_browser<cr>", { desc = "Pick file browser" })
			map("n", "<leader>ph", "<cmd>Telescope help_tags<cr>", { desc = "Pick neovim help" })
			map("n", "<leader>pl", "<cmd>Telescope loclist<cr>", { desc = "Pick location list" })
			map("n", "<leader>pm", "<cmd>Telescope man_pages<cr>", { desc = "Pick man pages" })
			map("n", "<leader>po", "<cmd>Telescope oldfiles<cr>", { desc = "Pick oldfiles list" })
			map("n", "<leader>pt", "<cmd>Telescope filetypes<cr>", { desc = "Pick filetypes list" })
			map("n", "<leader>pv", "<cmd>Telescope vim_options<cr>", { desc = "Pick vim options list" })

			map("n", "<leader>lc", "<cmd>Telescope colorscheme<cr>", { desc = "List colorscheme" })
			map("n", "<leader>lb", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "List document symbols" })
			map("n", "<leader>ld", "<cmd>Telescope diagnostics<cr>", { desc = "List diagnostic" })
			map("n", "<leader>lj", "<cmd>Telescope jumplist<cr>", { desc = "List jumplist" })
			map("n", "<leader>lk", "<cmd>Telescope keymaps<cr>", { desc = "List keymaps" })
			map("n", "<leader>ll", "<cmd>Telescope highlights<cr>", { desc = "List vim highlights" })
			map("n", "<leader>lm", "<cmd>Telescope marks<cr>", { desc = "List marks" })
			map("n", "<leader>lp", "<cmd>Telescope project<cr>", { desc = "List projectes" })
			map("n", "<leader>lq", "<cmd>Telescope quickfix<cr>", { desc = "List quickfix" })
			map("n", "<leader>lr", "<cmd>Telescope registers<cr>", { desc = "List registers" })
			map("n", "<leader>lt", "<cmd>Telescope tags<cr>", { desc = "List tags" })
			map("n", "<leader>ls", "<cmd>Telescope treesitter<cr>", { desc = "List treesitter" })

			map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "List git branches" })
			map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "List git commits" })
			map("n", "<leader>gd", "<cmd>Telescope git_bcommits<cr>", { desc = "List git buffer commits" })
			map("n", "<leader>gf", "<cmd>Telescope git_files<cr>", { desc = "List git files" })
			map("n", "<leader>gi", "<cmd>Telescope git_status<cr>", { desc = "List git status" })
			map("n", "<leader>gs", "<cmd>Telescope git_stash<cr>", { desc = "List git stash items" })
		end,
	},
}
