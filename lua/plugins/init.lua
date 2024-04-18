local M = {}
table.insert(M, require("plugins.ui.fold"))
table.insert(M, require("plugins.ui"))
table.insert(M, require("plugins.edit"))
table.insert(M, require("plugins.lsp"))
return M
