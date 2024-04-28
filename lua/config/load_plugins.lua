local M = {}
function M.setup()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.loop.fs_stat(lazypath) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			lazypath,
		})
	end
	vim.opt.rtp:prepend(lazypath)
	require("lazy").setup("plugins", {
		spec = nil,
		defaults = {
			lazy = false,
			version = false, -- always use the latest git commit
		},
		git = {
			-- defaults for the `Lazy log` command
			-- log = { "-10" }, -- show the last 10 commits
			log = { "-8" }, -- show commits from the last 3 days
			timeout = 120, -- kill processes that take more than 2 minutes
			url_format = "https://github.com/%s.git",
			-- lazy.nvim requires git >=2.19.0. If you really want to use lazy with an older version,
			-- then set the below to false. This should work, but is NOT supported and will
			-- increase downloads a lot.
			filter = true,
		},
		-- checker = { enabled = true }, -- automatically check for plugin updates
		performance = {
			rtp = {
				disabled_plugins = {
					"matchparen",
					"tarPlugin",
					"tohtml",
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
				},
			},
		},
	})
end

return M
