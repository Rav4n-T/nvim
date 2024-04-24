return {
	{
		"folke/noice.nvim",
		dependencies = {

			"MunifTanjim/nui.nvim",
		},
		event = "VeryLazy",
		opts = {
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
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
		config = function(_, opts)
			require("mini.indentscope").setup(opts)
		end,
	},
	{
		"declancm/cinnamon.nvim",
		event = "CursorMoved",
		config = function()
			require("cinnamon").setup({
				-- KEYMAPS:
				default_keymaps = true, -- Create default keymaps.
				extra_keymaps = false, -- Create extra keymaps.
				extended_keymaps = false, -- Create extended keymaps.
				override_keymaps = false, -- The plugin keymaps will override any existing keymaps.

				-- OPTIONS:
				always_scroll = true, -- Scroll the cursor even when the window hasn't scrolled.
				centered = true, -- Keep cursor centered in window when using window scrolling.
				disabled = false, -- Disables the plugin.
				default_delay = 7, -- The default delay (in ms) between each line when scrolling.
				hide_cursor = false, -- Hide the cursor while scrolling. Requires enabling termguicolors!
				horizontal_scroll = true, -- Enable smooth horizontal scrolling when view shifts left or right.
				max_length = -1, -- Maximum length (in ms) of a command. The line delay will be
				-- re-calculated. Setting to -1 will disable this option.
				scroll_limit = 150, -- Max number of lines moved before scrolling is skipped. Setting
				-- to -1 will disable this option.
			})
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		opts = {
			undercurl = false,
			underline = false,
			bold = true,
			italic = {
				strings = true,
				comments = true,
				operators = true,
				folds = true,
			},
			strikethrough = true,
			invert_selection = true,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = true,
			inverse = true, -- invert background for search, diffs, statuslines and errors
			contrast = "soft", -- can be "hard", "soft" or empty string
			palette_overrides = {},
			overrides = {
				String = { italic = false },
				DiagnosticVirtualTextError = { link = "GruvboxRed", italic = true },
				DiagnosticVirtualTextWarn = { italic = true },
				DiagnosticVirtualTextInfo = { italic = true },
				DiagnosticVirtualTextHint = { italic = true },
			},
			dim_inactive = false,
			transparent_mode = true,
		},
	},
	{
		"neanias/everforest-nvim",
		event = "VeryLazy",
		version = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("everforest").setup({
				background = "soft", -- soft | medium | hard
				transparent_background_level = 0.8,
				italics = true,
				disable_italic_comments = false,
				sign_column_background = "none",
				ui_contrast = "high", -- high | low
				dim_inactive_windows = true,
				diagnostic_text_highlight = true,
				diagnostic_virtual_text = "coloured", -- grey | coloured
				diagnostic_line_highlight = true,
				spell_foreground = false,
				show_eob = true,
				float_style = "dim", -- bright | dim
				-- on_highlights = function(hl, palette)
				-- 	hl.DiagnosticError = { fg = palette.none, bg = palette.none, sp = palette.red }
				-- 	hl.DiagnosticWarn = { fg = palette.none, bg = palette.none, sp = palette.yellow }
				-- 	hl.DiagnosticInfo = { fg = palette.none, bg = palette.none, sp = palette.blue }
				-- 	hl.DiagnosticHint = { fg = palette.none, bg = palette.none, sp = palette.green }
				-- end,
				colours_override = function(_) end,
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
					-- theme = "catppuccin",
					globalstatus = true,
					icons_enabled = true,
					-- component_separators = { left = "│", right = "│" },
					component_separators = { left = "|", right = "|" },
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
								-- readonly = "  ",
								-- unnamed = "  ",
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
				head = { cursor = "", texthl = "SmoothCursor", linehl = nil },
			},
		},
	},
}
