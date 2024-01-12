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
			go = { "goimports" },
			python = { "black" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			vue = { "prettier" },
			jsx = { "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			less = { "prettier" },
			scss = { "prettier" },
			json = { "prettier" },
			markdown = { "prettier" },
			yaml = { "prettier" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = false,
		},
	},
}

return M
