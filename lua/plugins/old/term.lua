local M = {
  "akinsho/toggleterm.nvim",
  version = "*",
  event = "VeryLazy",
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return 10
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = [[<c-\>]],
    on_open = function()
      local opts = { buffer = 0 }
      vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
    end,                 -- function to run when the terminal opens
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    highlights = {
      -- highlights which map to a highlight group name and a table of it's values
      -- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
      -- Normal = {
      --   guibg = "<VALUE-HERE>",
      -- },
      NormalFloat = {
        link = "Normal",
      },
      -- FloatBorder = {
      --   guifg = "<VALUE-HERE>",
      --   guibg = "<VALUE-HERE>",
      -- },
    },
    shade_terminals = true,       -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
    shading_factor = "-30",       -- the percentage by which to lighten terminal background, default: -30 (gets multiplied by -3 if background is light)
    start_in_insert = true,
    insert_mappings = true,       -- whether or not the open mapping applies in insert mode
    terminal_mappings = true,     -- whether or not the open mapping applies in the opened terminals
    persist_size = true,
    persist_mode = true,          -- if set to true (default) the previous terminal mode will be remembered
    direction = "float",          --| 'vertical' | 'horizontal' | 'tab' | 'float',
    close_on_exit = true,         -- close the terminal window when the process exits
    shell = "powershell -nologo", -- change the default shell
    auto_scroll = true,           -- automatically scroll to the bottom on terminal output
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
      border = "curved", -- | 'double' | 'shadow' | 'curved' | ... other options supported by win open
      -- like `size`, width and height can be a number or function which is passed the current terminal
      width = 80,
      height = 40,
      winblend = 0,
    },
    winbar = {
      enabled = false,
      name_formatter = function(term) --  term: Terminal
        return term.name
      end,
    },
  },
}
return M
