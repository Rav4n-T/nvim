local Util = require("utils")
local M = {
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
						{ "~/Desktop/Workspaces" },
						{ "~/Desktop/Projectes" },
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
	end,
}
return M
