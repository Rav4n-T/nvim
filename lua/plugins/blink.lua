local M = {
	{
		"saghen/blink.cmp",
		-- enabled = false,
		-- lazy = false, -- lazy loading handled internally
		-- optional: provides snippets for the snippet source
		event = { "InsertEnter" },
		dependencies = {
			{ dir = "~/Projectes/Git/fittencode.nvim" },
		},

		-- dependencies = {
		-- 	{ "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp" },
		-- },

		-- use a release tag to download pre-built binaries
		-- version = 'v0.*',
		-- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		build = "cargo build --release",
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' for mappings similar to built-in completion
			-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
			-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
			-- see the "default configuration" section below for full documentation on how to define
			-- your own keymap.
			keymap = {
				["<C-e>"] = { "show", "hide", "fallback" },
				["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<cr>"] = { "accept", "fallback" },
			},

			sources = {
				-- default = { "lsp", "path", "snippets", "buffer", "fittencode" },
				default = { "lsp", "path", "snippets", "buffer" },

				providers = {
					lsp = {
						min_keyword_length = 2,
					},
					snippets = {
						min_keyword_length = 2,
					},
					buffer = {
						min_keyword_length = 2,
					},
					fittencode = {
						name = "FC",
						min_keyword_length = 2,
						module = "fittencode.sources.blink",
					},
				},
			},
			completion = {
				accept = {
					auto_brackets = {
						enabled = true,
					},
				},
				menu = {
					auto_show = false,
					-- auto_show = function(ctx)
					-- 	return ctx.mode ~= "cmdline" or not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
					-- end,
					-- auto_show = function(ctx)
					-- 	return ctx.mode ~= "cmdline" or vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
					-- end,

					scrollbar = false,
					-- Controls how the completion items are rendered on the popup window
					draw = {
						columns = {
							{ "kind_icon" },
							{ "label", "label_description", gap = 2 },
							-- { "kind", "source_name", gap = 2 },
							{ "source_name", gap = 1 },
						},
					},
					-- components = {},
				},
				documentation = {
					-- Controls whether the documentation window will automatically show when selecting a completion item
					auto_show = true,
					window = {
						-- Note that the gutter will be disabled when border ~= 'none'
						scrollbar = false,
					},
				},
				-- Displays a preview of the selected item on the current line
				ghost_text = {
					enabled = true,
				},
			},

			appearance = {
				highlight_ns = vim.api.nvim_create_namespace("blink_cmp"),
				-- Sets the fallback highlight groups to nvim-cmp's highlight groups
				-- Useful for when your theme doesn't support blink.cmp
				-- Will be removed in a future release
				use_nvim_cmp_as_default = false,
				-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
				kind_icons = require("config.options").icons.kind_icons,
			},
		},
	},
}

return M
