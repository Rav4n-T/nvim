return {

	{
		"nvim-lualine/lualine.nvim",
		-- event = { "BufReadPost", "BufNewFile" },
		event = "BufEnter",
		dependencies = {
			"meuter/lualine-so-fancy.nvim",
		},
		enabled = true,
		-- lazy = false,
		config = function()
			local custom_auto = require("lualine.themes.auto")
			-- Change the background of lualine_c section to NONE for normal mode
			custom_auto.normal.a.bg = "NONE"
			custom_auto.normal.b.bg = "NONE"
			custom_auto.normal.c.bg = "NONE"
			custom_auto.insert.a.bg = "NONE"
			custom_auto.insert.b.bg = "NONE"
			custom_auto.insert.c.bg = "NONE"
			custom_auto.visual.a.bg = "NONE"
			custom_auto.visual.b.bg = "NONE"
			custom_auto.visual.c.bg = "NONE"
			custom_auto.command.a.bg = "NONE"
			custom_auto.command.b.bg = "NONE"
			custom_auto.command.c.bg = "NONE"
			-- local icons = require("config.icons")
			require("lualine").setup({
				options = {
					theme = custom_auto,
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
				extensions = { "nvim-tree", "lazy", "mason", "man", "nvim-dap-ui", "quickfix" },
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
				add = { text = "+" },
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
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		dependencies = {
			{ "HiPhish/rainbow-delimiters.nvim" },
		},
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
		config = function()
			local highlight = {
				"RainbowRed",
				"RainbowYellow",
				"RainbowBlue",
				"RainbowOrange",
				"RainbowGreen",
				"RainbowViolet",
				"RainbowCyan",
			}
			local hooks = require("ibl.hooks")
			-- create the highlight groups in the highlight setup hook, so they are reset
			-- every time the colorscheme changes
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
				vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
				vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
				vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
				vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
				vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
			end)

			vim.g.rainbow_delimiters = { highlight = highlight }
			require("ibl").setup({ scope = { highlight = highlight } })

			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
		end,
	},
}
