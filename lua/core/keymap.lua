local wk
if require("which-key") then
	wk = require("which-key")
end
local Util = require("utils")
local dap = require("dap")
local dapui = require("dapui")
-- local fn = require("core.fn")

wk.register({
	["<C-h>"] = { "<C-w>h", "go to the left window" },
	["<C-j>"] = { "<C-w>j", "go to the down window" },
	["<C-k>"] = { "<C-w>k", "go to the up window" },
	["<C-l>"] = { "<C-w>l", "go to the right window" },
	["<C-left>"] = { "<C-w>5<", "reduce the width of 5 window" },
	["<C-right>"] = { "<C-w>5>", "increase the width of 5 window" },
	["<C-down>"] = { "<C-w>5-", "increase the height of 5 window" },
	["<C-up>"] = { "<C-w>5+", "reduce the height of 5 window" },
	["<Tab>"] = { ":bnext<cr>", "go to next buffer" },
	["<S-Tab>"] = { ":bprevious<cr>", "go to previous buffer" },
	["K"] = { vim.lsp.buf.hover, "show info" },
	["<F6>"] = { "<cmd>DapStepOver<cr>", "Step over" },
	["<F7>"] = { "<cmd>DapStepInto<cr>", "Step into a func or method" },
	["<F8>"] = { "<cmd>DapStepOut<cr>", "Step out of a func or method" },
	["<F9>"] = { "<cmd>DapRunToCursor<cr>", "Continues execution to current cursor" },
	d = {
		name = "delete",
		H = { "d0", "delete to line head" },
		L = { "d$", "delete to line end" },
	},
	v = {
		name = "select",
		H = { "v0", "select to line head" },
		L = { "v$", "select to line end" },
	},
	g = {
		name = "goto",
		d = { "<cmd>Telescope lsp_definitions<cr>", "Jump to function definition" },
		r = { "<cmd>Telescope lsp_references<cr>", "Jump to function reference" },
		i = { "<cmd>Telescope lsp_implementations<cr>", "Server's implementation provider" },
		t = {
			"<cmd>Telescope lsp_type_definitions<cr>",
			"Goto the definition of the type of the word under the cursor",
		},
	},
	H = { "0", "go line start" },
	L = { "$", "go line end" },
})

wk.register({
	["<S-Tab>"] = { "<gv", "indent to the right" },
	["<Tab>"] = { ">gv", "indent to the left" },
}, { mode = "v" })

wk.register({
	a = {
		name = "actions",
		c = { vim.lsp.buf.code_action, "code actions" },
		f = { "<cmd>Format<cr>", "sync format current file" },
		r = { vim.lsp.buf.rename, "rename current cursor variable" },
		t = { require("nvim-toggler").toggle, "Invert current word" },
		k = { vim.lsp.buf.signature_help, "show signature help" },
	},
	b = {
		name = "buffer",
		d = {
			name = "delete",
			c = { "<cmd>BDelete this<cr>", "Delete current buffer" },
			o = { "<cmd>BDelete other<cr>", "Delete other buffers" },
		},
	},
	d = {
		name = "delete/diagnostics/debug",
		b = { "<cmd>DapToggleBreakpoint<cr>", "Creates or removes a breakpoint" },
		z = {
			function()
				dapui.float_element("stacks", { position = "center", width = 90, height = 80, enter = true })
			end,
			"Open float element: stack trace",
		},
		d = { "<cmd>DapTerminate<cr>", "Terminates the debug session" },
		n = { "<cmd>DapContinue<cr>", "Start debug or step run" },
		r = { "<cmd>DapRerun<cr>", "Restart the current session" },
		l = {
			function()
				dap.run_last()
			end,
			"Re-runs the last debug adapter configuration that ran using",
		},
		f = { "<cmd>DapRestartFrame<cr>", "Restart the current frame" },
		s = { "<cmd>DapStop<cr>", "Restart the current session" },
		t = { "<cmd>Telescope diagnostics<cr>", "Show all diagnostics list" },
	},
	f = {
		name = "file/find", -- optional group name
		b = { "<cmd>Telescope buffers<cr>", "Find Buffers" },
		f = { Util.telescope("files"), "Find File(root dir)" }, -- create a binding with label
		j = { "<cmd>Telescop jumplist<cr>", "Lists jump list" },
		p = { "<cmd>Telescop project<cr>", "Find projectes" },
		q = { "<cmd>Telescope quickfix<cr>", "Lists quickfix list" },
		r = { "<cmd>Telescope oldfiles<cr>", "Find old files" },
	},
	g = {
		name = "git",
		b = { "<cmd>Telescope git_branches<cr>", "Git branches" },
		c = { "<cmd>Telescope git_commits<cr>", "Git commits" },
		h = { "<cmd>Telescope git_stash<cr>", "Git stash" },
		s = { "<cmd>Telescope git_status<cr>", "Git status" },
	},
	s = {
		name = "Search",
		a = { "<cmd>Telescope autocommands<cr>", "Auto Commands" },
		b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Buffer" },
		c = { "<cmd>Telescope command_history<cr>", "Command History" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
		d = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
		g = { Util.telescope("live_grep"), "Grep (root dir)" },
		h = { "<cmd>Telescope help_tags<cr>", "Help Pages" },
		H = { "<cmd>Telescope highlights<cr>", "Search Highlight Groups" },
		k = { "<cmd>Telescope keymaps<cr>", "Key Maps" },
		m = { "<cmd>Telescope marks<cr>", "Jump to Mark" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		o = { "<cmd>Telescope vim_options<cr>", "Options" },
		R = { "<cmd>Telescope resume<cr>", "Resume" },
		t = { "<cmd>Telescope tags<cr>", "Lists tags" },
		w = { Util.telescope("grep_string"), "Word (root dir)" },
		W = { Util.telescope("grep_string", { cwd = false }), "Word (cwd)" },
		s = {
			Util.telescope("lsp_document_symbols", {
				symbols = {
					"Class",
					"Function",
					"Method",
					"Constructor",
					"Interface",
					"Module",
					"Struct",
					"Trait",
					"Field",
					"Property",
				},
			}),
			"Goto Symbol",
		},
		S = {
			Util.telescope("lsp_workspace_symbols", {
				symbols = {
					"Class",
					"Function",
					"Method",
					"Constructor",
					"Interface",
					"Module",
					"Struct",
					"Trait",
					"Field",
					"Property",
				},
			}),
			"Goto Symbol (Workspace)",
		},
	},
	-- t = {
	--   name = "Term",
	--   a = { "<cmd>1ToggleTerm<cr>", "Toggle the 1st float term window" },
	--   b = { "<cmd>2ToggleTerm direction=horizontal<cr>", "Toggle the 2nd horizontal term window" },
	--   c = { "<cmd>3ToggleTerm direction=horizontal<cr>", "Toggle the 3rd horizontal term window" },
	-- },
	u = {
		name = "Other Utils",
		c = { Util.telescope("colorscheme", { enable_preview = true }), "Colorscheme with preview" },
		n = { "<cmd>Telescope notify<cr>", "notify list" },
		p = { "<cmd>CccPick<cr>", "Color picker" },
		t = { "<cmd>Telescop<cr>", "Open Telescop" },
	},
}, { prefix = "<leader>" })
