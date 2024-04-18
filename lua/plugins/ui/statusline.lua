local M = {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	opts = function(_)
		local icons = require("core.options").icons

		local function fg(name)
			return function()
				---@type {foreground?:number}?
				local hl = vim.api.nvim_get_hl_by_name(name, true)
				return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
			end
		end

		return {
			options = {
				theme = "auto",
				globalstatus = true,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					{
						"branch",
					},
					{
						"diff",
						symbols = {
							added = icons.git.added,
							modified = icons.git.modified,
							removed = icons.git.removed,
						},
					},
				},
				lualine_c = {
					{ "filetype", icon_only = true, padding = { left = 1, right = 0 } },
					{
						"filename",
						path = 1,
						symbols = { modified = " ", readonly = " ", unnamed = "" },
					},
            -- -- stylua: ignore
            -- {
            --   function()
            --     return "%="
            --   end
            -- },
					{
						function()
							local msg = "No Active Lsp"
							local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
							local clients = vim.lsp.get_active_clients()
							if next(clients) == nil then
								return msg
							end
							for _, client in ipairs(clients) do
								local filetypes = client.config.filetypes
								if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
									return client.name
								end
							end
							return msg
						end,
						icon = " LSP:",
						color = { gui = "bold" },
					},
					{
						"diagnostics",
						symbols = {
							error = icons.diagnostics.Error,
							warn = icons.diagnostics.Warn,
							info = icons.diagnostics.Info,
							hint = icons.diagnostics.Hint,
						},
					},
				},
				lualine_x = {
					{
						require("lazy.status").updates,
						cond = require("lazy.status").has_updates,
						color = fg("Special"),
					},
				},
				lualine_y = {
					{ "encoding", padding = { left = 1, right = 0 } },
					{ "progress", separator = "", padding = { left = 1, right = 1 } },
					{ "location", padding = { left = 0, right = 1 } },
				},
				lualine_z = {
					function()
						return " " .. os.date("%R")
					end,
				},
			},
			extensions = { "neo-tree" },
		}
	end,
}
return M
