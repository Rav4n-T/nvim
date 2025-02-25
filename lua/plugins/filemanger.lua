return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{
				"<leader>e",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
				end,
				desc = "Explorer NeoTree (cwd)",
			},
		},
		deactivate = function()
			vim.cmd([[Neotree close]])
		end,
		config = function()
			require("neo-tree").setup({
				close_if_last_window = false,
				enable_git_status = true,
				enable_diagnostics = true,
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
						["s"] = "open_split",
						["S"] = "open_vsplit",
					},
				},
				default_component_configs = {
					indent = {
						with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
						expander_collapsed = "",
						expander_expanded = "",
						expander_highlight = "NeoTreeExpander",
					},
					modified = {
						symbol = "󰣕 ",
						highlight = "NeoTreeModified",
					},
					name = {
						trailing_slash = false,
						use_git_status_colors = false,
						highlight = "NeoTreeFileName",
					},
					diagnostics = {
						symbols = {
							error = " ",
							warn = " ",
							hint = " ",
							info = " ",
						},
					},
					git_status = {
						symbols = {
							-- Change type
							added = " ",
							modified = " ",
							removed = " ",
							deleted = "󰆴 ",
							-- Status type
							untracked = "",
							ignored = "",
							unstaged = "󰄱",
							staged = "",
							conflict = "",
						},
					},
				},
			})
		end,
	},
	{
		"stevearc/oil.nvim",
		keys = {
			{
				"<leader>o",
				function()
					require("oil").open_float()
				end,
				desc = "Explorer Oil (cwd)",
			},
		},
		opts = {},
		-- Optional dependencies
		-- dependencies = { { "echasnovski/mini.icons", opts = {} } },
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
	},
}
