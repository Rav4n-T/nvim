local M = {}

-- set lsp keymaps
M.setLspKeymap = function()
	local map = vim.keymap.set
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(ev)
			-- Enable completion triggered by <c-x><c-o>
			vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

			-- Buffer local mappings.
			-- See `:help vim.lsp.*` for documentation on any of the below functions
			map(
				"n",
				"gd",
				-- vim.lsp.buf.definition,
				"<cmd>FzfLua lsp_definitions<cr>",
				{ desc = "go to definition", buffer = ev.buf, remap = true, silent = true }
			)
			map(
				"n",
				"gt",
				-- vim.lsp.buf.type_definition,
				"<cmd>FzfLua lsp_type_definitions<cr>",
				{ desc = "go to type definition", buffer = ev.buf, remap = true, silent = true }
			)
			map(
				"n",
				"gD",
				vim.lsp.buf.declaration,
				{ desc = "go to declaration", buffer = ev.buf, remap = true, silent = true }
			)
			map("n", "K", vim.lsp.buf.hover, { desc = "lsp hover", buffer = ev.buf, remap = true, silent = true })
			map(
				"n",
				"gi",
				"<cmd>FzfLua lsp_implementations<cr>",
				-- vim.lsp.buf.implementation,
				{ desc = "go to implementation", buffer = ev.buf, remap = true, silent = true }
			)
			map(
				"n",
				"gr",
				-- vim.lsp.buf.references,
				"<cmd>FzfLua lsp_references<cr>",
				{ desc = "go to references", buffer = ev.buf, remap = true, silent = true }
			)
			map(
				"n",
				"gI",
				-- vim.lsp.buf.references,
				"<cmd>FzfLua lsp_incoming_calls<cr>",
				{ desc = "go to incoming calls", buffer = ev.buf, remap = true, silent = true }
			)
			map(
				"n",
				"go",
				-- vim.lsp.buf.references,
				"<cmd>FzfLua lsp_outgoing_calls<cr>",
				{ desc = "go to outgoing calls", buffer = ev.buf, remap = true, silent = true }
			)
			map(
				"n",
				"<C-f>",
				vim.lsp.buf.signature_help,
				{ desc = "show signature help doc", buffer = ev.buf, remap = true, silent = true }
			)
			map(
				"n",
				"<space>ar",
				vim.lsp.buf.rename,
				{ desc = "rename current word", buffer = ev.buf, remap = true, silent = true }
			)
			map(
				{ "n", "v" },
				"<space>ac",
				vim.lsp.buf.code_action,
				{ desc = "code actions", buffer = ev.buf, remap = true, silent = true }
			)
			map(
				"n",
				"<space>wa",
				vim.lsp.buf.add_workspace_folder,
				{ desc = "add workspace folder", buffer = ev.buf, remap = true, silent = true }
			)
			map(
				"n",
				"<space>wr",
				vim.lsp.buf.remove_workspace_folder,
				{ desc = "remove workspace folder", buffer = ev.buf, remap = true, silent = true }
			)
			map("n", "<space>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, { desc = "show workspace folders list", buffer = ev.buf, remap = true, silent = true })
		end,
	})
end

-- diagnostics signs
M.setDiagnosticsicon = function(opt)
	for name, icon in pairs(require("config.options").icons.diagnostics) do
		name = "DiagnosticSign" .. name
		vim.fn.sign_define(name, {
			text = icon, -- icon | ""
			texthl = name, -- "name" | ""
			linehl = "",
			numhl = "", -- "name" | ""
		})
	end
	vim.diagnostic.config(opt)
end

M.AttachFn = function(_, bufnr)
	vim.api.nvim_create_autocmd("CursorHold", {
		buffer = bufnr,
		callback = function()
			local hover_opts = {
				focusable = false,
				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
				border = "none",
				source = "always",
				prefix = " ",
				scope = "cursor",
			}
			vim.diagnostic.open_float(nil, hover_opts)
		end,
	})
end

M.setFloatWindow = function()
	local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or "single"
		opts.max_width = opts.max_width or 50
		return orig_util_open_floating_preview(contents, syntax, opts, ...)
	end
end

return M
