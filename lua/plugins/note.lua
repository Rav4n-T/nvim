return {
	{
		"nvim-neorg/neorg",
		version = "v7.0.0", -- This is the important part!
		build = ":Neorg sync-parsers",
		ft = { "org" },
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
