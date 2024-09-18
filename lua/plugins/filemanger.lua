return {
	{
		"nvim-tree/nvim-tree.lua",
		keys = {
			{
				"<leader>e",
				function()
					require("nvim-tree.api").tree.toggle({ path = vim.uv.cwd() })
				end,
				desc = "Explorer NvimTree (cwd)",
			},
		},
		config = function()
			local function my_on_attach(bufnr)
				local api = require("nvim-tree.api")

				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				-- default mappings
				api.config.mappings.default_on_attach(bufnr)

				-- custom mappings
				vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
				vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
				vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
			end

			require("nvim-tree").setup({
				on_attach = my_on_attach,
				sort = {
					sorter = "case_sensitive",
				},
				view = {
					width = 30,
				},
				renderer = {
					hidden_display = "all",
					group_empty = true,
					icons = {
						git_placement = "right_align",
						glyphs = {
							modified = "󰣕 ",
							git = {
								untracked = "",
								ignored = "",
								unstaged = "",
								staged = "",
							},
						},
					},
				},
				git = {
					show_on_open_dirs = false,
				},
				modified = {
					enable = true,
					show_on_open_dirs = false,
				},
				filters = {

					dotfiles = true,
				},
			})
		end,
	},
}
