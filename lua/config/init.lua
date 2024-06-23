local M = {}
local opts = require("config.options").options
local load_lazy = require("config.load_plugins")

function M.setup()
	-- set neovim options
	for opt_model, opts_set in pairs(opts) do
		for opt_key, opt_val in pairs(opts_set) do
			vim[opt_model][opt_key] = opt_val
		end
	end
	-- set lazy
	load_lazy.setup()
	-- keymap
	require("config.keymaps")
	-- autocommands
	require("config.fn")
	-- neovide
	if vim.g.neovide then
		require("config.neovide")
	end
	-- colorschema
	-- vim.cmd.colorscheme("catppuccin-macchiato")
	-- vim.cmd.colorscheme("catppuccin-mocha")
	vim.cmd.colorscheme("everforest")
	-- override_ui_input
	-- require("ui.input").override_ui_input()
end
return M
