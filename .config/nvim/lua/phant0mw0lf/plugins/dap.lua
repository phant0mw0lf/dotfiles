return {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" }, opts = {} },
    { "theHamsta/nvim-dap-virtual-text", opts = {} },
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = { "mason-org/mason.nvim" },
      opts = { ensure_installed = { "python", "coreclr" }, handlers = {} },
    },
    {
      "mfussenegger/nvim-dap-python",
      ft = "python",
      config = function()
        -- runs `uv run --with debugpy python`, so the project venv is used
        require("dap-python").setup("uv")
      end,
    },
  },
  keys = {
    {
      "<F5>",
      function()
        require("dap").continue()
      end,
      desc = "Debug: start / continue",
    },
    {
      "<F10>",
      function()
        require("dap").step_over()
      end,
      desc = "Debug: step over",
    },
    {
      "<F11>",
      function()
        require("dap").step_into()
      end,
      desc = "Debug: step into",
    },
    {
      "<S-F11>",
      function()
        require("dap").step_out()
      end,
      desc = "Debug: step out",
    },
    {
      "<leader>bb",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Toggle breakpoint",
    },
    {
      "<leader>bc",
      function()
        require("dap").set_breakpoint(vim.fn.input("Condition: "))
      end,
      desc = "Conditional breakpoint",
    },
    {
      "<leader>bl",
      function()
        require("dap").set_breakpoint(nil, nil, vim.fn.input("Log: "))
      end,
      desc = "Logpoint",
    },
    {
      "<leader>bx",
      function()
        require("dap").terminate()
      end,
      desc = "Terminate",
    },
    {
      "<leader>br",
      function()
        require("dap").repl.toggle()
      end,
      desc = "REPL",
    },
    {
      "<leader>bu",
      function()
        require("dapui").toggle()
      end,
      desc = "Toggle debug UI",
    },
    {
      "<leader>be",
      function()
        require("dapui").eval()
      end,
      desc = "Evaluate",
      mode = { "n", "v" },
    },
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")

    -- C# / .NET (netcoredbg via mason-nvim-dap "coreclr" handler)
    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "Launch .NET (pick dll)",
        request = "launch",
        program = function()
          return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
        end,
      },
      {
        type = "coreclr",
        name = "Attach to process",
        request = "attach",
        processId = require("dap.utils").pick_process,
      },
    }

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticWarn" })
    vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticInfo" })
    vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticOk", linehl = "Visual" })
  end,
}
