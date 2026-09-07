return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    opts = {
      flavour = "mocha",
      integrations = {
        blink_cmp = true,
        dap = true,
        dap_ui = true,
        diffview = true,
        flash = true,
        gitsigns = true,
        lsp_trouble = true,
        mason = true,
        neotest = true,
        render_markdown = true,
        snacks = { enabled = true },
        treesitter = true,
        treesitter_context = true,
        which_key = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      local lazy_status = require("lazy.status")
      return {
        options = { theme = "catppuccin", globalstatus = true },
        sections = {
          lualine_c = { { "filename", path = 1 } },
          lualine_x = {
            { lazy_status.updates, cond = lazy_status.has_updates, color = { fg = "#fab387" } },
            { "diagnostics" },
            { "encoding" },
            { "fileformat" },
            { "filetype" },
          },
        },
      }
    end,
  },

  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = { mode = "tabs", separator_style = "slant", diagnostics = "nvim_lsp" },
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      spec = {
        { "<leader>a", group = "ai / claude code" },
        { "<leader>b", group = "debug" },
        { "<leader>c", group = "code" },
        { "<leader>e", group = "explorer" },
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git" },
        { "<leader>h", group = "git hunks" },
        { "<leader>m", group = "notebook (molten)" },
        { "<leader>n", group = "neotest" },
        { "<leader>r", group = "rename / lsp" },
        { "<leader>s", group = "split" },
        { "<leader>t", group = "tab" },
        { "<leader>u", group = "toggle" },
        { "<leader>w", group = "session" },
        { "<leader>x", group = "trouble" },
      },
    },
  },
}
