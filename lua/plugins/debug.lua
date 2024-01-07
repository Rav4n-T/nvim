local M = {
  "mfussenegger/nvim-dap",
  keys = {
    {
      "<leader>db",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Creates or removes a breakpoint",
    },
  },
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      opts = {
        layouts = {
          {
            elements = {
              "scopes",
              "stacks",
              "breakpoints",
              "watches",
            },
            size = 0.3, -- 40 columns
            position = "left",
          },
          {
            elements = {
              "repl",
            },
            size = 0.25, -- 25% of total lines
            position = "bottom",
          },
          {
            elements = {
              "console",
            },
            size = 0.2,
            position = "right",
          },
        },
        floating = {
          max_height = nil,  -- These can be integers or a float between 0 and 1.
          max_width = nil,   -- Floats will be treated as percentage of your screen.
          border = "single", -- Border style. Can be "single", "double" or "rounded"
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
      },
      config = function(_, opts)
        local dap = require("dap")
        local dapui = require("dapui")
        local dap_breakpoint = require("config.debugs").dap_breakpoint

        vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
        vim.fn.sign_define("DapBreakpointCondition", dap_breakpoint.condition)
        vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
        vim.fn.sign_define("DapLogPoint", dap_breakpoint.logpoint)
        vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)

        dapui.setup(opts)

        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open({})
        end
        dap.listeners.after.disconnect["dapui_config"] = function()
          dapui.close({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close({})
        end
      end,
    },
    {
      "theHamsta/nvim-dap-virtual-text",
      config = function()
        require("nvim-dap-virtual-text").setup()
      end,
    },
  },
  config = function()
    local dap = require("dap")
    local adapters = require("config.debugs.adapters")
    local pyCfg = require("config.debugs.python")
    local cCfg = require("config.debugs.c")

    dap.adapters.python = adapters.python
    dap.configurations.python = pyCfg

    -- dap.adapters.codelldb = adapters.codelldb
    -- dap.adapters.lldb = adapters.lldb
    dap.adapters.cppdbg = adapters.cppdbg

    dap.configurations.c = cCfg.cppdbg
    dap.configurations.cpp = cCfg.cppdbg
    dap.configurations.rust = cCfg.cppdbg
  end,
}
return M

