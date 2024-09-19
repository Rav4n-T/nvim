return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
		dependencies = {
			{ "HiPhish/rainbow-delimiters.nvim" },
		},
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			---@diagnostic disable-next-line missing-fields
			configs.setup({
				ensure_installed = "all",
				highlight = {
					enable = true,
					disable = function(_, buf) -- first args is lang
						local max_filesize = 50 * 1024
						local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
				},
				indent = {
					enable = true,
				},
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "html" },
		config = true,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			fast_wrap = {
				map = "<C-e>",
				chars = { "{", "[", "(", '"', "'", "`" },
				pattern = [=[[%'%"%>%]%)%}%,]]=],
				end_key = "j",
				before_key = "h",
				after_key = "l",
				cursor_pos_before = false,
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				manual_position = true,
				highlight = "Search",
				highlight_grey = "Comment",
			},
		},
		-- config = true,
		-- use opts = {} for passing setup options
		-- this is equalent to setup({}) function
	},

	{
		"echasnovski/mini.ai",
		event = "VeryLazy",
		version = false,
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "BufEnter",
		config = function()
			require("nvim-surround").setup({})
		end,
	},

	-- Comment
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "html", "vue" },
		lazy = true,
		config = function()
			local tcc = require("ts_context_commentstring")
			local tcc_internal = require("ts_context_commentstring.internal")

			tcc.setup({
				enable_autocmd = false,
			})

			local orig_get_option = vim.filetype.get_option
			local custom_get_option = function(filetype, option)
				return option == "commentstring" and tcc_internal.calculate_commentstring()
					or orig_get_option(filetype, option)
			end
			vim.filetype.get_option = custom_get_option
		end,
	},

	-- Format
	{
		"stevearc/conform.nvim",
		event = "InsertLeave",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				java = { "clang_format" },
				rust = { "rustfmt" },
				go = { "goimports-reviser" },
				python = { "black" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				vue = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				less = { "prettier" },
				scss = { "prettier" },
				json = { "prettier" },
				jsonc = { "prettier" },
				markdown = { "prettier" },
				yaml = { "prettier" },
				sql = { "sqlfmt" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = false,
			},
		},

		init = function()
			local map = vim.keymap.set
			local create_command = vim.api.nvim_create_user_command
			-- create user command
			create_command("Format", function(args)
				local range = nil
				if args.count ~= -1 then
					local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
					range = {
						start = { args.line1, 0 },
						["end"] = { args.line2, end_line:len() },
					}
				end
				require("conform").format({ async = true, lsp_fallback = true, range = range })
			end, { range = true })

			-- Format
			map("v", "f", "<cmd>Format<cr>", { desc = "format current selection", remap = true, silent = true })
			map("n", "<leader>af", "<cmd>Format<cr>", { desc = "format current file", remap = true, silent = true })
		end,
	},
	{
		"mg979/vim-visual-multi",
		branch = "master",
		event = "VeryLazy",
		init = function()
			vim.g.VM_set_statusline = 0
		end,
	},
}
