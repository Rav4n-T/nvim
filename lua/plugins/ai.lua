local M = {
	"Exafunction/codeium.vim",
	event = "InsertEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
	},
	-- config = function()
	-- require("codeium").setup({})
	-- vim.g.codeium_disable_bindings = true
	-- end,
}

return M
