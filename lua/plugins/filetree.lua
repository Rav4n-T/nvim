local M = {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	cmd = "Neotree",
	keys = {
		{
			"<leader>e",
			function()
				require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
			end,
			desc = "Explorer NeoTree (cwd)",
		},
	},
	deactivate = function()
		vim.cmd([[Neotree close]])
	end,
	--		init = function()
	--			vim.g.neo_tree_remove_legacy_commands = 1
	--			if vim.fn.argc() == 1 then
	--				local stat = vim.loop.fs_stat(vim.fn.argv(0))
	--				if stat and stat.type == "directory" then
	--					require("neo-tree")
	--				end
	--			end
	--		end,
	opts = {
		filesystem = {
			bind_to_cwd = true,
			follow_current_file = {
				enabled = true,
			},
		},
		window = {
			width = 30,
			mappings = {
				["<space>"] = "none",
				["l"] = "open",
				["L"] = "focus_preview",
			},
		},
		default_component_configs = {
			indent = {
				with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
				expander_collapsed = "",
				expander_expanded = "",
				expander_highlight = "NeoTreeExpander",
			},
		},
	},
}

return M
