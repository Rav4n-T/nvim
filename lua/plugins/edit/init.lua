local M = {}
table.insert(M, require("plugins.edit.cmp"))
table.insert(M, require("plugins.edit.comment"))
table.insert(M, require("plugins.edit.cut"))
table.insert(M, require("plugins.edit.format"))
table.insert(M, require("plugins.edit.indent"))
table.insert(M, require("plugins.edit.lastplace"))
table.insert(M, require("plugins.edit.move"))
table.insert(M, require("plugins.edit.pairs"))
table.insert(M, require("plugins.edit.surround"))
table.insert(M, require("plugins.edit.toggle"))
table.insert(M, require("plugins.edit.treesitter"))
table.insert(M, require("plugins.edit.visual-multi"))
return M
