return {
	{
		"j-hui/fidget.nvim",
		config = function()
			local fidget = require("fidget")

			local IGNORE_MESSAGE = {
				"textDocument/documentColor is not supported",
			}

			fidget.setup({
				progress = {
					display = {
						render_limit = 2,
						progress_icon = { pattern = "meter", period = 1 },
					},
				},
				notification = {
					override_vim_notify = true,
					configs = {
						default = vim.tbl_extend("force", require("fidget.notification").default_config, {
							name = "Notify",
							-- icon = "󰅂󰅂",
							icon = "󰅁󰅁",
							icon_on_left = true,
							icon_style = "NotifyINFOIcon",
							debug_style = "NotifyDEBUGTitle",
							info_style = "NotifyINFOTitle",
							warn_style = "NotifyWARNTitle",
							error_style = "NotifyERRORTitle",
						}),
					},

					-- Conditionally redirect notifications to another backend
					redirect = function(msg, level, opts)
						for _, match in ipairs(IGNORE_MESSAGE) do
							if msg:find(match) then
								return true
							end
						end
						if opts and opts.on_open then
							return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
						end
					end,
					window = {
						normal_hl = "NotifyINFOTitle",
						winblend = 0,
						-- align = "top",
					},
					view = {
						-- stack_upwards = false,
					},
				},
			})
		end,
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
