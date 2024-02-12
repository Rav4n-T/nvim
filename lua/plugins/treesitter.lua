local M = {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		{ "windwp/nvim-ts-autotag" },
		{ "HiPhish/rainbow-delimiters.nvim" },
	},
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = {
				"vim",
				"vimdoc",
				"query",
				"lua",
				"c",
				"cpp",
				"rust",
				"go",
				"javascript",
				"typescript",
				"tsx",
				"vue",
				"html",
				"css",
				"scss",
				"json",
				"jsonc",
				"regex",
				"markdown",
				"markdown_inline",
			},
			sync_install = false,
			highlight = {
				enable = true,
				disable = function(_, buf) -- first args is lang
					local max_filesize = 50 * 1024
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
			},
			indent = { enable = true },
			autotag = { enable = true },
		})
	end,
}

return M
