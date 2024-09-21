return {
	{
		"j-hui/fidget.nvim",
		event = "VeryLazy",
		config = function()
			local fidget = require("fidget")
			-- local map = vim.keymap.set
			--
			-- local IGNORE_MESSAGE = {
			-- 	"textDocument/documentColor is not supported",
			-- }

			fidget.setup({
				progress = {
					display = {
						render_limit = 2,
						progress_icon = { pattern = "meter", period = 1 },
					},
				},
				notification = {
					-- override_vim_notify = true,
					-- configs = {
					-- 	default = vim.tbl_extend("force", require("fidget.notification").default_config, {
					-- 		name = "Notify",
					-- 		icon = "󰅁󰅁",
					-- 		icon_on_left = true,
					-- 		icon_style = "NotifyINFOIcon",
					-- 		debug_style = "NotifyDEBUGTitle",
					-- 		info_style = "NotifyINFOTitle",
					-- 		warn_style = "NotifyWARNTitle",
					-- 		error_style = "NotifyERRORTitle",
					-- 	}),
					-- },

					-- Conditionally redirect notifications to another backend
					-- redirect = function(msg, level, opts)
					-- 	for _, match in ipairs(IGNORE_MESSAGE) do
					-- 		if msg:find(match) then
					-- 			return true
					-- 		end
					-- 	end
					-- 	if opts and opts.on_open then
					-- 		return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
					-- 	end
					-- end,
					window = {
						-- normal_hl = "NotifyINFOTitle",
						winblend = 0,
						-- align = "top",
					},
					view = {
						-- stack_upwards = false,
					},
				},
			})

			-- map("n", "<leader>nh", "<cmd>Fidget history<cr>", { desc = "Noice History", remap = true, silent = true })
		end,
	},

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
