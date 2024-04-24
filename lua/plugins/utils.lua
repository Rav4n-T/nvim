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
		"echasnovski/mini.pick",
		event = "VeryLazy",
		version = false,
		config = function()
			local map = vim.keymap.set
			local win_config = function()
				local height = math.floor(0.618 * vim.o.lines)
				local width = math.floor(0.8 * vim.o.columns)
				return {
					anchor = "NW",
					height = height,
					width = width,
					row = math.floor(0.5 * (vim.o.lines - height)),
					col = math.floor(0.5 * (vim.o.columns - width)),
				}
			end
			require("mini.pick").setup({
				window = {
					config = win_config,
				},
			})
			map("n", "<leader>bl", "<cmd>Pick buffers<cr>", { desc = "Pick Buffer" })
			map("n", "<leader>ff", "<cmd>Pick files list<cr>", { desc = "Pick File" })
			map("n", "<leader>fw", "<cmd>Pick grep_live<cr>", { desc = "Pick Grep live" })
			map("n", "<leader>px", "<cmd>Pick help<cr>", { desc = "Pick Help" })
			map("n", "<leader>pz", "<cmd>Pick resume<cr>", { desc = "Pick Resume" })
		end,
	},
	{
		"echasnovski/mini.extra",
		event = "VeryLazy",
		version = false,
		config = function()
			local map = vim.keymap.set
			local lspPicker = require("mini.extra").pickers.lsp
			local listPicker = require("mini.extra").pickers.list
			local picker = require("mini.extra").pickers
			require("mini.extra").setup()

			map("n", "<leader>ls", function()
				lspPicker({ scope = "document_symbol" })
			end, { desc = "Pick document symbols", remap = true, silent = true })

			map("n", "<leader>lw", function()
				lspPicker({ scope = "workspace_symbol" })
			end, { desc = "Pick Workspace symbols", remap = true, silent = true })

			map("n", "<leader>lq", function()
				listPicker({ scope = "quickfix" })
			end, { desc = "Pick quickfix list", remap = true, silent = true })
			map("n", "<leader>pl", function()
				listPicker({ scope = "location" })
			end, { desc = "Pick location list", remap = true, silent = true })
			map("n", "<leader>lj", function()
				listPicker({ scope = "jump" })
			end, { desc = "Pick jump list", remap = true, silent = true })
			map("n", "<leader>pc", function()
				listPicker({ scope = "change" })
			end, { desc = "Pick change list", remap = true, silent = true })

			map("n", "<leader>pa", picker.commands, { desc = "Pick commands list", remap = true, silent = true })
			map("n", "<leader>ld", picker.diagnostic, { desc = "Pick diagnostic list", remap = true, silent = true })
			map("n", "<leader>le", picker.explorer, { desc = "Pick file explorer", remap = true, silent = true })
			map("n", "<leader>ph", picker.history, { desc = "Pick history list", remap = true, silent = true })
			map("n", "<leader>lk", picker.keymaps, { desc = "Pick keymaps list", remap = true, silent = true })
			map("n", "<leader>lb", picker.buf_lines, { desc = "Pick buffer lines list", remap = true, silent = true })
			map("n", "<leader>lm", picker.marks, { desc = "Pick marks list", remap = true, silent = true })
			map("n", "<leader>lt", picker.treesitter, { desc = "Pick treesitter nodes", remap = true, silent = true })
			map("n", "<leader>po", picker.oldfiles, { desc = "Pick oldfiles list", remap = true, silent = true })
			map("n", "<leader>lr", picker.registers, { desc = "Pick registers list", remap = true, silent = true })

			map("n", "<leader>gb", picker.git_branches, { desc = "Pick git branches", remap = true, silent = true })
			map("n", "<leader>gc", picker.git_commits, { desc = "Pick git commits", remap = true, silent = true })
			map("n", "<leader>gf", picker.git_files, { desc = "Pick git files", remap = true, silent = true })
			map("n", "<leader>gt", function()
				picker.git_files({ scope = "tracked" })
			end, { desc = "Pick git files with tracked", remap = true, silent = true })
			map("n", "<leader>gi", function()
				picker.git_files({ scope = "ignored" })
			end, { desc = "Pick git files with ignored", remap = true, silent = true })
			map("n", "<leader>gm", function()
				picker.git_files({ scope = "modified" })
			end, { desc = "Pick git files with modified", remap = true, silent = true })
			map("n", "<leader>gf", function()
				picker.git_files({ scope = "untracked" })
			end, { desc = "Pick git files with untracked", remap = true, silent = true })
			map("n", "<leader>gd", function()
				picker.git_files({ scope = "deleted" })
			end, { desc = "Pick git files with deleted", remap = true, silent = true })

			map("n", "<leader>gb", picker.git_branches, { desc = "Pick git branches", remap = true, silent = true })
			map(
				"n",
				"<leader>gu",
				picker.git_hunks,
				{ desc = "Pick git hunks with unstaged", remap = true, silent = true }
			)
			map("n", "<leader>gs", function()
				picker.git_hunks({ scope = "staged" })
			end, { desc = "Pick git hunks with staged", remap = true, silent = true })
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			plugins = { spelling = true },
			defaults = {
				mode = { "n", "v" },
				["g"] = { name = "+goto" },
				["s"] = { name = "+surround" },
				["z"] = { name = "+fold" },
				["]"] = { name = "+next" },
				["["] = { name = "+prev" },
				["<leader>a"] = { name = "+Action" },
				["<leader>b"] = { name = "+Buffer" },
				["<leader>d"] = { name = "+Debug" },
				["<leader>f"] = { name = "+Find" },
				["<leader>g"] = { name = "+Git" },
				["<leader>l"] = { name = "+List" },
				["<leader>n"] = { name = "+Notify" },
				["<leader>p"] = { name = "+Picker" },
				["<leader>w"] = { name = "+Lsp Workspace" },
			},
		},
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.register(opts.defaults)
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
