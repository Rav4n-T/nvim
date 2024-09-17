return {
	{
		"nvim-neorg/neorg",
		cond = function()
			local note_dir = vim.fn.findfile("index.norg", vim.fn.getcwd() .. ";")
			if note_dir ~= "" then
				return true
			else
				return false
			end
		end,
		version = "v7.0.0", -- This is the important part!
		build = ":Neorg sync-parsers",
		ft = { "norg" },
		opts = {
			load = {
				["core.defaults"] = {},
				["core.summary"] = {},
				["core.completion"] = {
					config = {
						engine = "nvim-cmp",
					},
				},
				["core.concealer"] = {},
				["core.dirman"] = {
					config = {
						workspaces = {
							notes = "~/Projectes/Notes",
						},
					},
				},
			},
		},
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},
}
