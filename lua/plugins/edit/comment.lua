local M = {
	-- "numToStr/Comment.nvim",
	"echasnovski/mini.comment",
	version = "*",
	event = "BufEnter",
	config = function()
		-- require("Comment").setup()
		require("mini.comment").setup({
			mappings = {
				comment = "<leader>c",
				comment_line = "<leader>cc",
				comment_visual = "<leader>c",
				textobject = "<leader>c",
			},
		})
	end,
}
return M
