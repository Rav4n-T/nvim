return {
	{
		"nvim-telescope/telescope.nvim",
		-- cmd = "Telescope",
		event = "VeryLazy",
		version = false, -- telescope did only one release, so use HEAD for now
		dependencies = {
			{ "nvim-telescope/telescope-project.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		opts = function()
			local actions = require("telescope.actions")
			local themes = require("telescope.themes")
			return {
				defaults = themes.get_dropdown({
					file_ignore_patterns = { "node_modules", ".obsidian", ".terraform", "%.jpg", "%.png" },
					scroll_strategy = "cycle",
					preview = false,
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
					width = 1,
					prompt_title = false,
				}),
				pickers = {
					find_files = {
						find_command = { "fd", "-tf" },
					},
					buffers = {
						initial_mode = "insert",
					},
					live_grep = {
						preview = true,
					},
					grep_string = {
						initial_mode = "normal",
						preview = true,
					},
				},
				extensions = {
					project = {
						theme = "dropdown",
						base_dirs = {
							-- { "~/Workspaces" },
							-- { "~/Projectes" },
							-- { "~/Desktop/Workspaces" },
							-- { "~/Desktop/Projectes" },
						},
						hidden_files = true,
						sync_with_nvim_tree = true,
					},
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
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
			tel.load_extension("fzf")

			map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Search File" })
			map("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "Search world Grep live" })
			map("n", "<leader>fi", "<cmd>Telescope<cr>", { desc = "Telescope" })
		end,
	},
}
