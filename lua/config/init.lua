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
	-- autocommands
	require("config.fn")
	-- colorschema
	vim.cmd.colorscheme("everforest")
	-- override_ui_input
	-- require("ui.input").override_ui_input()
	vim.filetype.add({
		extension = {
			["http"] = "http",
		},
	})
end
return M
