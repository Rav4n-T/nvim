return {
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		keys = {
			{
				"<leader>nx",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Dismiss All Notifications",
			},
		},
		opts = {
			stages = "static",
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
			on_open = function(win)
				vim.api.nvim_win_set_config(win, { zindex = 100 })
			end,
		},
		init = function()
			local utils = require("utils")
			-- when noice is not enabled, install notify on VeryLazy
			utils.on_very_lazy(function()
				vim.notify = require("notify")
			end)
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			---@type false | "classic" | "modern" | "helix"
			preset = "helix",
			spec = {
				mode = { "n", "v" },
				{ "g", group = "goto" },
				{ "s", group = "surround" },
				{ "z", group = "fold" },
				{ "]", group = "next" },
				{ "", group = "prev" },
				{ "<leader>a", group = "Action" },
				{ "<leader>b", group = "Buffer" },
				{ "<leader>d", group = "Debug" },
				{ "<leader>f", group = "Find" },
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
	-- Move
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			modes = {
				char = {
					jump_labels = true,
				},
			},
		},
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
				custom_colors = {
					-- label property will be used as a pattern initially(string.gmatch), therefore you need to escape the special characters by yourself with %
					-- { label = "%-%-theme%-font%-color", color = "#fff" },
					-- { label = "%-%-theme%-background%-color", color = "#23222f" },
					-- { label = "%-%-theme%-primary%-color", color = "#0f1219" },
					-- { label = "%-%-theme%-secondary%-color", color = "#5a5d64" },
					-- { label = "%-%-theme%-contrast%-color", color = "#fff" },
					-- { label = "%-%-theme%-accent%-color", color = "#55678e" },
				},
			})
		end,
	},
}
