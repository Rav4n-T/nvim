local M = {
--	Autopairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			fast_wrap = {
				map = "<C-e>",
				chars = { "{", "[", "(", '"', "'", "`" },
				pattern = [=[[%'%"%>%]%)%}%,]]=],
				end_key = "j",
				before_key = "h",
				after_key = "l",
				cursor_pos_before = false,
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				manual_position = true,
				highlight = "Search",
				highlight_grey = "Comment",
			},
		},
		-- config = true,
		-- use opts = {} for passing setup options
		-- this is equalent to setup({}) function
	},

	-- Surround
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "BufEnter",
		config = function()
			require("nvim-surround").setup({})
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
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
					selection_caret = " ",
					mappings = {
						i = {
							["<C-q>"] = actions.close,
						},
					},
				}),
				layout_config = {
					horizontal = {
						preview_cutoff = 100,
						preview_width = 0.5,
					},
				},
				pickers = {
					find_files = {
						find_command = { "fd", "-tf" },
						previewer = false,
					},
					buffers = {
						initial_mode = "insert",
						previewer = false,
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
			require("telescope").setup(opts)
			require("telescope").load_extension("project")
			require("telescope").load_extension("noice")
		end,
	},
}

