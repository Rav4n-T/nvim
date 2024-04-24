local M = {
	"yaocccc/nvim-hl-mdcodeblock.lua",
	ft = "markdown", -- or 'event = "VeryLazy"'
	config = function()
		require("hl-mdcodeblock").setup()
	end,
}

return M
