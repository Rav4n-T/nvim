local M = {
	"nvim-treesitter/nvim-treesitter",
	version = false,
	build = function()
		require("nvim-treesitter.install").update({ with_sync = true })
	end,
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		{ "windwp/nvim-ts-autotag" },
	},
	opts = {
		highlight = {
			enable = true,
			disable = function(lang, buf)
				local max_filesize = 50 * 1024
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,
		},
		indent = { enable = true, disable = { "python" } },
		context_commentstring = { enable = true, enable_autocmd = false },
		ensure_installed = {
			"regex",
			"bash",
			"c",
			"cpp",
			"rust",
			"go",
			"html",
			"javascript",
			"typescript",
			"json",
			"jsonc",
			"lua",
			"markdown",
			"markdown_inline",
			"python",
			"tsx",
			"php",
			"yaml",
			"vue",
			"css",
			"scss",
			"query",
			"vim",
			"vimdoc",
		},
		incremental_selection = {
			enable = false,
		},
		autotag = { enable = true },
		-- rainbow = {enable = true, extended_mode = true, max_file_lines = nil}
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
		-- require("nvim-treesitter.install").compilers = { "clang" }
	end,
}

return M
