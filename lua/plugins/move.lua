local M = {
  "folke/flash.nvim",
  keys = {
    {
      "/",
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
  },
  opts = {},
}
return M
