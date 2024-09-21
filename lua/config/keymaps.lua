local map = vim.keymap.set

-- butter up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- window priver key
map("n", "<leader>w", "<C-w>", { desc = "window operate", remap = true, silent = true })

-- window jump
map("n", "<C-h>", "<C-w>h", { desc = "go to the left window", remap = true, silent = true })
map("n", "<C-j>", "<C-w>j", { desc = "go to the down window", remap = true, silent = true })
map("n", "<C-k>", "<C-w>k", { desc = "go to the up window", remap = true, silent = true })
map("n", "<C-l>", "<C-w>l", { desc = "go to the right window", remap = true, silent = true })

-- window resize
map("n", "<C-left>", "<C-w>5<", { desc = "reduce the width of 5 window", remap = true, silent = true })
map("n", "<C-right>", "<C-w>5>", { desc = "increase the width of 5 window", remap = true, silent = true })
map("n", "<C-down>", "<C-w>5-", { desc = "increase the height of 5 window", remap = true, silent = true })
map("n", "<C-up>", "<C-w>5+", { desc = "reduce the height of 5 window", remap = true, silent = true })

-- indent line
map("v", "<Tab>", ">gv", { desc = "indent to the left", remap = true, silent = true })
map("v", "<S-Tab>", "<gv", { desc = "indent to the right", remap = true, silent = true })

-- move line
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "move line down", remap = true, silent = true })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "move line up", remap = true, silent = true })

-- Navigate buffer
map("n", "<S-Tab>", ":bprevious<CR>", { desc = "go to previous buffer", remap = true, silent = true })
map("n", "<Tab>", ":bnext<CR>", { desc = "go to next buffer", remap = true, silent = true })

-- Stronger H/L
map("n", "H", "^", { desc = "go to the head of the line", remap = true, silent = true })
map("n", "L", "$", { desc = "go to the end of the line", remap = true, silent = true })
map("n", "dH", "d0", { desc = "delete to the head of the line", remap = true, silent = true })
map("n", "dL", "d$", { desc = "delete to the end of the line", remap = true, silent = true })
map("n", "cH", "c0", { desc = "change to the head of the line", remap = true, silent = true })
map("n", "cL", "c$", { desc = "change to the end of the line", remap = true, silent = true })
map("n", "vH", "v0", { desc = "select to the head of the line", remap = true, silent = true })
map("n", "vL", "v$", { desc = "select to the end of the line", remap = true, silent = true })

-- Add Undo break points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ":", ":<c-g>u")
map("i", ";", ";<c-g>u")
map("i", "!", "!<c-g>u")
map("i", "?", "?<c-g>u")
map("i", "/", "/<c-g>u")
map("i", "\\", "\\<c-g>u")

-- delete buffer
local bufferUtil = require("utils.buffer")
map("n", "<leader>bd", bufferUtil.del_current_buffer, { desc = "delete current buffer", remap = true, silent = true })
map("n", "<leader>bo", bufferUtil.del_other_buffers, { desc = "delete other buffers", remap = true, silent = true })

-- diagnostic
local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- git
local lazygit = require("internal.lazygit")
map("n", "<leader>tg", lazygit.open, { desc = "open lazygit", remap = true, silent = true })

-- term
local term = require("internal.term")
map("n", "<leader>to", term.open, { desc = "open term", remap = true, silent = true })

-- yazi
local yazi = require("internal.yazi")
map("n", "<leader>ty", yazi.open, { desc = "open yazi", remap = true, silent = true })
