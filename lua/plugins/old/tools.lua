return {
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
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		event = "VeryLazy",
		opts = {
			lsp = {
				progress = {
					enabled = true,
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
}
