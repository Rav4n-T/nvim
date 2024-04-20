local M = {
	"rcarriga/nvim-notify",
	opts = {
		timeout = 5000,
		max_height = function()
			return math.floor(vim.o.lines * 0.75)
		end,
		max_width = function()
			return math.floor(vim.o.columns * 0.75)
		end,

		background_colour = "#000000",
		stages = "slide", -- fade_in_slide_out | fade | slide | static
		render = "wrapped-compact",
		icons = {
			DEBUG = "",
			ERROR = "",
			INFO = "",
			TRACE = "✎",
			WARN = "",
		},
		top_down = false,
	},
	init = function()
		vim.notify = require("notify")
	end,
	config = function(_, opts)
		-- Utility functions shared between progress reports for LSP and DAP
		--		local client_notifs = {}
		--
		--		local function get_notif_data(client_id, token)
		--			if not client_notifs[client_id] then
		--				client_notifs[client_id] = {}
		--			end
		--
		--			if not client_notifs[client_id][token] then
		--				client_notifs[client_id][token] = {}
		--			end
		--
		--			return client_notifs[client_id][token]
		--		end
		--
		--		local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }
		--
		--		local function update_spinner(client_id, token)
		--			local notif_data = get_notif_data(client_id, token)
		--
		--			if notif_data.spinner then
		--				local new_spinner = (notif_data.spinner + 1) % #spinner_frames
		--				notif_data.spinner = new_spinner
		--
		--				notif_data.notification = vim.notify(_, nil, {
		--					hide_from_history = true,
		--					icon = spinner_frames[new_spinner],
		--					replace = notif_data.notification,
		--				})
		--
		--				vim.defer_fn(function()
		--					update_spinner(client_id, token)
		--				end, 100)
		--			end
		--		end
		--
		--		local function format_title(title, client_name)
		--			return client_name .. (#title > 0 and ": " .. title or "")
		--		end
		--
		--		local function format_message(message, percentage)
		--			return (percentage and percentage .. "%\t" or "") .. (message or "")
		--		end
		--
		--		-- LSP integration
		--		-- Make sure to also have the snippet with the common helper functions in your config!
		--		vim.lsp.handlers["$/progress"] = function(_, result, ctx)
		--			local client_id = ctx.client_id
		--			local val = result.value
		--
		--			if vim.lsp.get_client_by_id(client_id).name ~= "jdtls" then
		--				if not val.kind then
		--					return
		--				end
		--
		--				local notif_data = get_notif_data(client_id, result.token)
		--
		--				if val.kind == "begin" then
		--					local message = format_message(val.message, val.percentage)
		--
		--					notif_data.notification = vim.notify(message, vim.log.levels.INFO, {
		--						title = format_title(val.title, vim.lsp.get_client_by_id(client_id).name),
		--						icon = spinner_frames[1],
		--						timeout = false,
		--						hide_from_history = false,
		--					})
		--
		--					notif_data.spinner = 1
		--					update_spinner(client_id, result.token)
		--				elseif val.kind == "report" and notif_data then
		--					notif_data.notification =
		--						vim.notify(format_message(val.message, val.percentage), vim.log.levels.INFO, {
		--							replace = notif_data.notification,
		--							hide_from_history = false,
		--						})
		--				elseif val.kind == "end" and notif_data then
		--					notif_data.notification =
		--						vim.notify(val.message and format_message(val.message) or "Complete", vim.log.levels.INFO, {
		--							icon = "",
		--							replace = notif_data.notification,
		--							timeout = 3000,
		--						})
		--
		--					notif_data.spinner = nil
		--				end
		--			end
		--		end

		-- table from lsp severity to vim severity.
		local severity = {
			"error",
			"warn",
			"info",
			"info", -- map both hint and info to info?
		}
		vim.lsp.handlers["window/showMessage"] = function(_, method, params, _)
			vim.notify(method.message, severity[params.type])
		end

		require("notify").setup(opts)
	end,
}
return M
