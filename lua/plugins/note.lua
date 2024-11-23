return {
	-- {
	-- 	"nvim-neorg/neorg",
	-- 	cond = function()
	-- 		local note_dir = vim.fn.findfile("index.norg", vim.fn.getcwd() .. ";")
	-- 		if note_dir ~= "" then
	-- 			return true
	-- 		else
	-- 			return false
	-- 		end
	-- 	end,
	-- 	version = "v7.0.0", -- This is the important part!
	-- 	build = ":Neorg sync-parsers",
	-- 	ft = { "norg" },
	-- 	opts = {
	-- 		load = {
	-- 			["core.defaults"] = {},
	-- 			["core.summary"] = {},
	-- 			["core.completion"] = {
	-- 				config = {
	-- 					engine = "nvim-cmp",
	-- 				},
	-- 			},
	-- 			["core.concealer"] = {},
	-- 			["core.dirman"] = {
	-- 				config = {
	-- 					workspaces = {
	-- 						notes = "~/Projectes/Notes",
	-- 					},
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- 	dependencies = { { "nvim-lua/plenary.nvim" } },
	-- },
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown" },
		opts = {},
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	},
	{
		"3rd/image.nvim",
		build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
		opts = {
			backend = "kitty",
			processor = "magick_cli",
			markdown = {
				clear_in_insert_mode = true,
				only_render_image_at_cursor = true,
			},
			max_width_window_percentage = 50,
			max_height_window_percentage = 50,
			window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
			editor_only_render_when_focused = true,
			tmux_show_only_in_active_window = false,
		},
	},
}
