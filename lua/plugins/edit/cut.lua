local M = {
	-- Lua
	"gbprod/cutlass.nvim",
	opts = {
		cut_key = "x",
		override_del = nil,
		exclude = {},
		registers = {
			select = "_",
			delete = "_",
			change = "_",
		},
	},
}
return M
