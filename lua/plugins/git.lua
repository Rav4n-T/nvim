return {
	{
		"NeogitOrg/neogit",
		cond = function()
			local git_dir = vim.fn.finddir(".git", vim.fn.getcwd() .. ";")
			if git_dir ~= "" then
				return true
			else
				return false
			end
		end,
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration
			"nvim-telescope/telescope.nvim", -- optional
		},
		config = true,
	},
}
