local M = {
  -- "numToStr/Comment.nvim",
  'echasnovski/mini.comment',
  version = '*',
  event = "InsertEnter",
  config = function()
    -- require("Comment").setup()
    require("mini.comment").setup()
  end,
}
return M
