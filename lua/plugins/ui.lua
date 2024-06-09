return {
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
			cmdline = {
				view = "cmdline",
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
				{
					filter = {
						event = "notify",
						any = {
							{ find = "No information available" },
							{ find = "[Neo-tree]" },
						},
					},
					opts = { skip = true },
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = true,
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
		"echasnovski/mini.indentscope",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			symbol = "╎",
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
				callback = function()
					---@diagnostic disable-next-line missing-fields
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
		config = function(_, opts)
			require("mini.indentscope").setup(opts)
		end,
	},
	{
		"catppuccin/nvim",
		event = "VeryLazy",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
					-- loops = { "bold" },
					functions = { "italic" },
					-- keywords = {},
					-- strings = { "italic" },
					variables = { "italic" },
					-- numbers = {},
					-- booleans = { "bold" },
					-- properties = { "italic" },
					-- types = { "bold" },
					operators = {},
				},
				color_overrides = {
					latte = {
						-- custom everforest dark hard port
						rosewater = "#fed1cb",
						flamingo = "#ff9185",
						pink = "#d699b6",
						mauve = "#cb7ec8",
						red = "#e06062",
						maroon = "#e67e80",
						peach = "#e69875",
						yellow = "#d3ad63",
						green = "#b0cc76",
						teal = "#6db57f",
						sky = "#7fbbb3",
						sapphire = "#60aaa0",
						blue = "#59a6c3",
						lavender = "#e0d3d4",
						text = "#e8e1bf",
						subtext1 = "#e0d7c3",
						subtext0 = "#d3c6aa",
						overlay2 = "#9da9a0",
						overlay1 = "#859289",
						overlay0 = "#6d6649",
						surface2 = "#585c4a",
						surface1 = "#414b50",
						surface0 = "#374145",
						base = "#1f2428",
						mantle = "#161b1d",
						crust = "#14181a",
					},
					macchiato = {
						rosewater = "#FB4834",
						flamingo = "#FB4834",
						red = "#FB4834",
						maroon = "#FB4834",
						pink = "#d3859b",
						mauve = "#d3859b",
						peach = "#e78a4e",
						yellow = "#FBBD2E",
						green = "#8dc07c",
						teal = "#B9BB25",
						sky = "#99c792",
						sapphire = "#99c792",
						blue = "#8dbba3",
						lavender = "#8dbba3",
						text = "#f1e4c2",
						subtext2 = "#c5b4a1",
						subtext1 = "#d5c4a1",
						subtext0 = "#bdae93",
						overlay2 = "#a89984",
						overlay1 = "#928374",
						overlay0 = "#595959",
						surface2 = "#4d4d4d",
						surface1 = "#404040",
						surface0 = "#292929",
						base = "#1d2224",
						mantle = "#1d2224",
						crust = "#1f2223",
					},
					frappe = {
						rosewater = "#eb7a73",
						flamingo = "#eb7a73",
						red = "#eb7a73",
						maroon = "#eb7a73",
						pink = "#e396a4",
						mauve = "#e396a4",
						peach = "#e89a5e",
						yellow = "#E7B84C",
						green = "#7cb66a",
						teal = "#99c792",
						sky = "#99c792",
						sapphire = "#99c792",
						blue = "#8dbba3",
						lavender = "#8dbba3",
						text = "#f1e4c2",
						subtext1 = "#e5d5b1",
						subtext0 = "#c5bda3",
						overlay2 = "#b8a994",
						overlay1 = "#a39284",
						overlay0 = "#656565",
						surface2 = "#5d5d5d",
						surface1 = "#505050",
						surface0 = "#393939",
						base = "#1d2224",
						mantle = "#1d2224",
						crust = "#1f2223",
					},
				},
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = { "BufReadPost", "BufNewFile", "VeryLazy" },
		dependencies = {
			"meuter/lualine-so-fancy.nvim",
		},
		enabled = true,
		lazy = false,
		config = function()
			-- local icons = require("config.icons")
			require("lualine").setup({
				options = {
					theme = "auto",
					globalstatus = true,
					icons_enabled = true,
					component_separators = { left = "│", right = "│" },
					-- component_separators = { left = "|", right = "|" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = {
							"alfa-nvim",
							"help",
							"neo-tree",
							"Trouble",
							"spectre_panel",
							"toggleterm",
						},
						winbar = {},
					},
				},
				sections = {
					lualine_a = {},
					lualine_b = {
						"fancy_branch",
					},
					lualine_c = {
						"fancy_diff",
						"fancy_lsp_servers",
						{
							"fancy_diagnostics",
							sources = { "nvim_lsp" },
							symbols = { error = " ", warn = " ", info = " " },
						},
						{ "fancy_searchcount" },
					},
					lualine_x = {
						{
							"filename",
							path = 0, -- 2 for full path
							symbols = {
								modified = "  ",
								readonly = "  ",
								unnamed = "  ",
							},
						},
						"location",
						"progress",
					},
					lualine_y = {},
					lualine_z = {},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					-- lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				extensions = { "neo-tree", "lazy" },
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {
			signs = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			watch_gitdir = {
				interval = 1000,
				follow_files = true,
			},
			attach_to_untracked = true,
			current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 1000,
				ignore_whitespace = false,
			},
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil, -- Use default
			max_file_length = 40000, -- Disable if file is longer than this (in lines)
			preview_config = {
				-- Options passed to nvim_open_win
				border = "single",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
			yadm = {
				enable = false,
			},
		},
	},
	{
		"gen740/SmoothCursor.nvim",
		event = "CursorMoved",
		opts = {
			fancy = {
				enable = true,
				head = { cursor = "", texthl = "SmoothCursor", linehl = nil },
			},
		},
	},
}
