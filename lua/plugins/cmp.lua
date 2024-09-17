local M = {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		{ "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "saadparwaiz1/cmp_luasnip" },
		-- { "dcampos/nvim-snippy" },
		-- { "dcampos/cmp-snippy" },
		{ "hrsh7th/cmp-cmdline" },
		-- { "hrsh7th/cmp-buffer" },
		-- { "ray-x/cmp-treesitter" },
		{ "hrsh7th/cmp-nvim-lua" },
		{ "kola-web/cmp-path" },
		{
			"MattiasMTS/cmp-dbee",
			dependencies = {
				{ "kndndrj/nvim-dbee" },
			},
			ft = "sql", -- optional but good to have
			opts = {}, -- needed
		},
	},
	opts = {},
	config = function(_, _)
		local luasnip = require("luasnip")
		-- local snippy = require("snippy")
		local cmp = require("cmp")
		local kind_icons = require("config.options").icons.kind_icons

		require("luasnip").setup({
			region_check_events = "CursorHold,InsertLeave",
			delete_check_events = "TextChanged,InsertEnter",
		})
		-- require("luasnip.loaders.from_vscode").lazy_load()
		-- require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
		require("luasnip.loaders.from_snipmate").lazy_load()

		-- gray
		vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { bg = "NONE", strikethrough = true, fg = "#D5C4A1" })
		-- blue
		vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { bg = "NONE", fg = "#D79921" })
		vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { bg = "NONE", fg = "#282828" })
		-- light blue
		vim.api.nvim_set_hl(0, "CmpItemKindVariable", { bg = "NONE", fg = "#689D6A" })
		vim.api.nvim_set_hl(0, "CmpItemKindInterface", { bg = "NONE", fg = "#CC241D" })
		vim.api.nvim_set_hl(0, "CmpItemKindText", { bg = "NONE", fg = "#3C8588" })
		-- pink
		vim.api.nvim_set_hl(0, "CmpItemKindFunction", { bg = "NONE", fg = "#B16286" })
		vim.api.nvim_set_hl(0, "CmpItemKindMethod", { link = "CmpItemKindFunction" })
		-- front
		vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { bg = "NONE", fg = "#FBF1C7" })
		vim.api.nvim_set_hl(0, "CmpItemKindProperty", { bg = "NONE", fg = "#D65D0E" })
		vim.api.nvim_set_hl(0, "CmpItemKindUnit", { link = "CmpItemKindKeyword" })

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
			---@diagnostic disable-next-line missing-fields
			performance = {
				max_view_entries = 10,
			},
			-- preselect = cmp.PreselectMode.Item, -- cmp.PreselectMode.None | cmp.PreselectMode.Item
			completion = {
				keyword_length = 1,
			},
			window = {
				-- completion = cmp.config.window.bordered(),
				-- documentation = cmp.config.window.bordered(),
			},
			---@diagnostic disable-next-line missing-fields
			formatting = {
				format = function(entry, vim_item)
					-- Kind icons
					-- vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
					vim_item.kind = string.format(" %s", kind_icons[vim_item.kind] or vim_item.kind) -- This concatenates the icons with the name of the item kind
					-- Source
					vim_item.menu = ({
						nvim_lsp = "(Lsp)",
						luasnip = "(Snp)",
						-- nvim_lua = "(Lua)",
						fittencode = "(FC)",
						path = "(Pth)",
						buffer = "(Buf)",
						neorg = "(Org)",
						["cmp-dbee"] = "(DB)",
					})[entry.source.name]
					return vim_item
				end,
			},
			matching = {
				disallow_fuzzy_matching = true,
				disallow_fullfuzzy_matching = true,
				disallow_partial_matching = true,
				disallow_partial_fuzzy_matching = true,
				disallow_prefix_unmatching = true,
				disallow_symbol_nonprefix_matching = true,
			},
			sorting = {
				priority_weight = 2,
				comparators = {
					cmp.config.compare.offset, -- 偏移量(没看懂)
					cmp.config.compare.exact, -- 精确匹配
					cmp.config.compare.scopes, -- 局部变量比全局变量高
					cmp.config.compare.recently_used, -- 最近使用
					cmp.config.compare.order, -- 根据id 越小
					cmp.config.compare.score, -- 根据设置的排名索引分数
					cmp.config.compare.locality, -- 离当前光标越近
					cmp.config.compare.kind, -- 类型越小越高
					cmp.config.compare.length, -- 字符越短
				},
			},
			experimental = {
				ghost_text = true, -- this feature conflict with copilot.vim's preview.
			},
			-- snippet = {
			-- 	expand = function(args)
			-- 		snippy.expand_snippet(args.body)
			-- 	end,
			-- },
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			sources = cmp.config.sources({
				{
					name = "nvim_lsp",
					keyword_pattern = [[\k\+]],
					priority = 9,
					group_index = 1,
				},
				{
					name = "cmp-dbee",
					keyword_pattern = [[\k\+]],
					priority = 9,
					group_index = 1,
				},
				{ name = "luasnip", priority = 9, group_index = 1 },
				-- { name = "snippy", priority = 9, group_index = 1 },
				{ name = "fittencode", keyword_pattern = [[\k\+]], priority = 7, group_index = 1 },
				{ name = "buffer", keyword_pattern = [[\k\+]], priority = 7, group_index = 1 },
				-- { name = "treesitter", priority = 7, group_index = 1 },
				{ name = "nvim_lua", priority = 8, group_index = 1 },
				{
					name = "path",
					keyword_pattern = [[\k\+]],
					priority = 7,
					group_index = 1,
				},
				{ name = "neorg" },
			}),
			mapping = cmp.mapping.preset.insert({
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					-- elseif snippy.can_expand_or_advance() then
					-- 	snippy.expand_or_advance()
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
					-- elseif snippy.can_jump(-1) then
					-- 	snippy.preious()
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
		})
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = { { name = "buffer" } },
		})
	end,
}
return M
