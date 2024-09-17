return {
	{
		"j-hui/fidget.nvim",
		opts = {
			-- options
			notification = {
				override_vim_notify = true,
				history_size = 128,

				view = {
					stack_upwards = false,
				},

				-- Option related to the notification window and buffer
				window = {
					winblend = 0, -- NOTE: it's winblend, not blend
					align = "top",
				},
			},
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>", mode = { "n", "v" }, silent = true },
		},
		opts = {
			---@type false | "classic" | "modern" | "helix"
			preset = "classic",
			delay = 200,
			spec = {
				mode = { "n", "v" },
				{ "g", group = "goto" },
				{ "s", group = "surround" },
				{ "z", group = "fold" },
				{ "]", group = "next" },
				{ "", group = "prev" },
				{ "<leader>a", group = "Action" },
				{ "<leader>b", group = "Buffer or dbee" },
				{ "<leader>d", group = "Debug" },
				{ "<leader>f", group = "Find" },
				{ "<leader>h", group = "Kulala" },
				{ "<leader>g", group = "Git" },
				{ "<leader>l", group = "List" },
				{ "<leader>n", group = "Notify" },
				{ "<leader>p", group = "Picker" },
				{ "<leader>w", group = "Lsp Workspace" },
			},
		},
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
	},
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
					require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
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
		"ethanholz/nvim-lastplace",
		event = "BufRead",
		opts = {
			lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
			lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
			lastplace_open_folds = true,
		},
	},
	{
		"kazhala/close-buffers.nvim",
		event = "InsertLeave",
		config = function()
			local map = vim.keymap.set
			map(
				"n",
				"<leader>bd",
				"<cmd>BDelete this<cr>",
				{ desc = "delete current buffer", remap = true, silent = true }
			)
			map(
				"n",
				"<leader>bo",
				"<cmd>BDelete other<cr>",
				{ desc = "delete other buffers", remap = true, silent = true }
			)
		end,
	},
	{
		"brenoprata10/nvim-highlight-colors",
		event = "BufRead",
		config = function()
			require("nvim-highlight-colors").setup({
				-- @usage 'background'|'foreground'|'virtual'
				render = "virtual",
				virtual_symbol = "",
				enable_named_colors = true,
				enable_tailwind = true,
			})
		end,
	},
}
