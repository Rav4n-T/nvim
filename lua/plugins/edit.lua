return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
		dependencies = {
			-- { "HiPhish/rainbow-delimiters.nvim" },
			{ "nvim-treesitter/nvim-treesitter-textobjects" },
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
				textobjects = {
					select = {
						enable = true,

						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,

						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							-- You can optionally set descriptions to the mappings (used in the desc parameter of
							-- nvim_buf_set_keymap) which plugins like which-key display
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
							-- You can also use captures from other query groups like `locals.scm`
							["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
						},
					},
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
		"m4xshen/autoclose.nvim",
		event = "VeryLazy",
		config = function()
			require("autoclose").setup({
				options = {
					disabled_filetypes = { "text" },
					disable_when_touch = false,
					touch_regex = "[%w(%[{]",
					pair_spaces = true,
					disable_command_mode = false,
				},
			})
		end,
	},
	{
		"echasnovski/mini.surround",
		version = false,
		event = "InsertEnter",
		config = function()
			require("mini.surround").setup()
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
			-- create_command("Format", function(args)
			-- 	local range = nil
			-- 	if args.count ~= -1 then
			-- 		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
			-- 		range = {
			-- 			start = { args.line1, 0 },
			-- 			["end"] = { args.line2, end_line:len() },
			-- 		}
			-- 	end
			-- 	require("conform").format({ async = true, lsp_fallback = true, range = range })
			-- end, { range = true })
			--
			-- Format
			map("v", "<leader>f", "<cmd>Format<cr>", { desc = "format current selection", remap = true, silent = true })
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
