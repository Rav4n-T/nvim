local M = {}
table.insert(M, require("plugins.ui.cmdline"))
table.insert(M, require("plugins.ui.color"))
table.insert(M, require("plugins.ui.colorschem"))
table.insert(M, require("plugins.ui.cursor"))
table.insert(M, require("plugins.ui.scroll"))
table.insert(M, require("plugins.ui.gitsign"))
table.insert(M, require("plugins.ui.md"))
table.insert(M, require("plugins.ui.msg"))
table.insert(M, require("plugins.ui.statusline"))
table.insert(M, require("plugins.ui.fold"))
return M
