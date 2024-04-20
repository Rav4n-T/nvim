local M = {
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
		-- formatters = {
		-- 	prettier = {
		-- 		args = { "--stdin-filepath", "$FILENAME" },
		-- 	},
		-- },
	},
}

return M
