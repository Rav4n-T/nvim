local M = {
	-- "jiangmiao/auto-pairs",
	"m4xshen/autoclose.nvim",
	event = "InsertEnter",
	config = function()
		require("autoclose").setup({
			keys = {
				-- ["<"] = { escape = true, close = true, pair = "<>", disabled_filetypes = { "cpp" } },
			},
			options = {
				disable_when_touch = true,
				touch_regex = "[%w(%[%{]",
				pair_spaces = true,
			},
		})
	end,
}
return M
