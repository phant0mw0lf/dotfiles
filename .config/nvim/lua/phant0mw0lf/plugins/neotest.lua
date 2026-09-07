return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-python",
    "Issafalcon/neotest-dotnet",
  },
  keys = {
    {
      "<leader>nr",
      function()
        require("neotest").run.run()
      end,
      desc = "Run nearest test",
    },
    {
      "<leader>nf",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Run test file",
    },
    {
      "<leader>na",
      function()
        require("neotest").run.run(vim.uv.cwd())
      end,
      desc = "Run all tests",
    },
    {
      "<leader>nd",
      function()
        require("neotest").run.run({ strategy = "dap" })
      end,
      desc = "Debug nearest test",
    },
    {
      "<leader>nl",
      function()
        require("neotest").run.run_last()
      end,
      desc = "Run last test",
    },
    {
      "<leader>ns",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Toggle test summary",
    },
    {
      "<leader>no",
      function()
        require("neotest").output.open({ enter = true, auto_close = true })
      end,
      desc = "Show test output",
    },
    {
      "<leader>nO",
      function()
        require("neotest").output_panel.toggle()
      end,
      desc = "Toggle output panel",
    },
    {
      "<leader>nx",
      function()
        require("neotest").run.stop()
      end,
      desc = "Stop test",
    },
    {
      "<leader>nw",
      function()
        require("neotest").watch.toggle(vim.fn.expand("%"))
      end,
      desc = "Watch file",
    },
  },
  opts = function()
    return {
      adapters = {
        require("neotest-python")({ runner = "pytest", dap = { justMyCode = false } }),
        require("neotest-dotnet")({ dap = { adapter_name = "coreclr" } }),
      },
      status = { virtual_text = true },
      output = { open_on_run = true },
    }
  end,
}
