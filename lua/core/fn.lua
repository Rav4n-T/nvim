local wk = require("which-key")
local utils = require("utils")

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 300,
    })
  end,
})

-- Use mingw build file in windows
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "c,cpp",
--   callback = function()
--     local ft = vim.fn.expand("%:e")
--     -- local ft = vim.bo.filetype()
--     if ft == "c" then
--       wk.register({
--         ["<F4>"] = {
--           -- '<cmd>2TermExec direction=horizontal cmd="gcc % -o %:t:r.exe"<cr>',
--           "Compile the current c file",
--         },
--       })
--     elseif ft == "cpp" then
--       wk.register({
--         ["<F4>"] = {
--           -- '<cmd>2TermExec direction=horizontal cmd="g++ % -o %:t:r.exe"<cr>',
--           "Compile the current cpp file",
--         },
--       })
--     end
--   end,
-- })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "c,cpp,python",
  callback = function()
    wk.register({
      ["<F5>"] = {
        utils.runCode,
        "Compilite or Run",
      },
    })
  end,
})
-- vim.api.nvim_create_autocmd("InsertLeave", {
--   callback = function()
--     Format
--   end,
-- })
