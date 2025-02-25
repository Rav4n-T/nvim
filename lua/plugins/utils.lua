return {
	{
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		event = "VeryLazy",
		opts = {
			cmdline = {
				format = {
					search_down = {
						view = "cmdline",
					},
					search_up = {
						view = "cmdline",
					},
				},
			},
			lsp = {
				progress = {
					enabled = false,
				},
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "%d+L, %d+B" },
							{ find = "; after #%d+" },
							{ find = "; before #%d+" },
							{ find = "%d fewer lines" },
							{ find = "%d more lines" },
							{ find = "%d lines yanked" },
						},
					},
					opts = { skip = true },
				},
				-- {
				-- 	filter = {
				-- 		event = "notify",
				-- 		any = {
				-- 			{ find = "No information available" },
				-- 			{ find = "[Neo-tree]" },
				-- 		},
				-- 	},
				-- 	opts = { skip = true },
				-- },
			},
			views = {
				mini = {
					win_options = {
						winblend = 0,
					},
				},
			},
		},
			    -- stylua: ignore
			    keys = {
			      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
			      { "<leader>nl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
			      { "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice History" },
			      { "<leader>na", function() require("noice").cmd("all") end, desc = "Noice All" },
			      { "<leader>nd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
			      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
			      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
			    }
,
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			bigfile = { enabled = false },
			dashboard = { enabled = true },
			explorer = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			picker = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			-- scroll = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
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
				{ "<leader>a", group = "Action+AI" },
				{ "<leader>b", group = "Buffer or dbee" },
				{ "<leader>d", group = "Debug" },
				{ "<leader>f", group = "Find" },
				{ "<leader>h", group = "Http" },
				{ "<leader>t", group = "Terminal" },
				{ "<leader>n", group = "Notify" },
				{ "<leader>w", group = "Lsp Workspace" },
			},
		},
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
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
		"brenoprata10/nvim-highlight-colors",
		event = "BufRead",
		config = function()
			require("nvim-highlight-colors").setup({
				-- @usage 'background'|'foreground'|'virtual'
				render = "background",
				virtual_symbol = "",
				enable_named_colors = true,
				enable_tailwind = true,
			})
		end,
	},
}
