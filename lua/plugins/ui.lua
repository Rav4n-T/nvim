return {
	{
		"echasnovski/mini.indentscope",
		event = { "BufEnter" },
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
			})
		end,
	},
	{
		"neanias/everforest-nvim",
		event = "BufEnter",
		lazy = true,
		priority = 1000, -- make sure to load this before all the other start plugins
		-- Optional; default configuration will be used if setup isn't called.
		config = function()
			require("everforest").setup({
				on_highlights = function(hl, palette)
					hl.DiagnosticError = { fg = palette.none, bg = palette.none, sp = palette.red }
					hl.DiagnosticWarn = { fg = palette.none, bg = palette.none, sp = palette.yellow }
					hl.DiagnosticInfo = { fg = palette.none, bg = palette.none, sp = palette.blue }
					hl.DiagnosticHint = { fg = palette.none, bg = palette.none, sp = palette.green }
					hl.TSBoolean = { fg = palette.purple, bg = palette.none, bold = true }
				end,
				background = "soft",
				transparent_background_level = 2,
				italics = true,
				disable_italic_comments = false,
				sign_column_background = "none",
				ui_contrast = "high",
				dim_inactive_windows = false,
				diagnostic_text_highlight = false,
				diagnostic_virtual_text = "coloured",
				diagnostic_line_highlight = true,
				spell_foreground = true,
				show_eob = true,
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		-- event = { "BufReadPost", "BufNewFile" },
		event = "VeryLazy",
		dependencies = {
			"meuter/lualine-so-fancy.nvim",
		},
		enabled = true,
		-- lazy = false,
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
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				extensions = { "neo-tree", "lazy", "mason", "man", "nvim-dap-ui", "quickfix" },
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		cond = function()
			local git_dir = vim.fn.finddir(".git", vim.fn.getcwd() .. ";")
			if git_dir ~= "" then
				return true
			else
				return false
			end
		end,
		event = "BufEnter",
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
	{
		"stevearc/dressing.nvim",
		opts = {},
	},
}
