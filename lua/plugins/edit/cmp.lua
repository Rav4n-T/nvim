local M = {
	"hrsh7th/nvim-cmp",
	dependencies = {
		{ "L3MON4D3/LuaSnip" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-buffer" },
		{ "kola-web/cmp-path" },
		{ "hrsh7th/cmp-nvim-lua" },
		{ "hrsh7th/cmp-cmdline" },
		{ "saadparwaiz1/cmp_luasnip" },
	},
	event = { "InsertEnter", "CmdlineEnter" },
	opts = {},
	config = function(_, _)
		local luasnip = require("luasnip")
		local cmp = require("cmp")

		require("luasnip").setup({
			region_check_events = "CursorHold,InsertLeave",
			delete_check_events = "TextChanged,InsertEnter",
		})
		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })

		cmp.setup({
			enabled = function()
				local buf = vim.api.nvim_get_current_buf()
				-- disable completion in comments
				local context = require("cmp.config.context")
				-- keep command mode completion enabled when cursor is in a comment
				if
					not vim.api.nvim_get_mode().mode == "c"
					and (context.in_treesitter_capture("comment") or context.in_syntax_group("Comment"))
				then
					return false
				end

				if vim.bo.filetype == "TelescopePrompt" or vim.bo.filetype == "neo-tree-popup" then
					return false
				end
				if string.match(vim.api.nvim_buf_get_name(buf), "%.min%.") == ".min." then
					return false
				end
				return true
			end,
			completion = {
				keyword_length = 1,
			},
			performance = {
				max_view_entries = 10,
			},
			experimental = {
				ghost_text = true, -- this feature conflict with copilot.vim's preview.
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			sources = cmp.config.sources({
				{ name = "nvim_lua", priority = 8 },
				{ name = "nvim_lsp", trigger_characters = { "-" }, priority = 8 },
				{ name = "luasnip", priority = 7 },
				{ name = "codeium", priority = 6 },
			}, {
				{ name = "buffer", priority = 7 },
				{
					name = "path",
					-- option = {
					-- 	pathMappings = {
					-- 		["@"] = "${folder}/src",
					-- 		["/"] = "${folder}/public/",
					-- 	},
					-- },
				},
			}),
			mapping = cmp.mapping.preset.insert({
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					-- elseif utils.has_words_before() then
					-- 	cmp.complete()
					else
						fallback()
					end
				end, {
					"i",
					"s",
				}),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, {
					"i",
					"s",
				}),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
			}),
			sorting = {
				-- priority_weight = 2,
				comparators = {
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.scopes,
					cmp.config.compare.score,
					cmp.config.compare.recently_used,
					cmp.config.compare.locality,
					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},
		})
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = { { name = "buffer" } },
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({ { name = "async_path" } }, { { name = "cmdline" } }),
		})
	end,
}
return M
