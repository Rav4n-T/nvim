local M = {
  "nguyenvukhang/nvim-toggler",

  event = "VeryLazy",
  config = function()
    require("nvim-toggler").setup({
      -- your own inverses
      inverses = {
        ["vim"] = "emacs",
        ["1"] = "0",
        ["dark"] = "light",
      },
      -- removes the default <leader>i keymap
      remove_default_keybinds = true,
    })
  end,
}
return M
