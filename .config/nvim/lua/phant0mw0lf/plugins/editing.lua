return {
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    opts = { skip_ts = { "string" }, skip_unbalanced = true, markdown = true },
  },

  {
    "kylechui/nvim-surround",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    -- v4: keymaps are <Plug> mappings. Visual-mode S belongs to flash, so surround a selection with gs / gS.
    init = function()
      vim.g.nvim_surround_no_visual_mappings = true
    end,
    opts = {},
    keys = {
      { "gs", "<Plug>(nvim-surround-visual)", mode = "x", desc = "Surround selection" },
      { "gS", "<Plug>(nvim-surround-visual-line)", mode = "x", desc = "Surround selection (own lines)" },
    },
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash jump",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash treesitter select",
      },
      {
        "<C-space>",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Expand selection (treesitter)",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter search",
      },
    },
  },

  {
    -- VS Code style multi-cursor: <C-n> adds a cursor on the next match of the word / selection
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    event = "VeryLazy",
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()
      local set = vim.keymap.set
      set({ "n", "x" }, "<C-n>", function()
        mc.matchAddCursor(1)
      end, { desc = "Add cursor at next match" })
      set({ "n", "x" }, "<C-Up>", function()
        mc.lineAddCursor(-1)
      end, { desc = "Add cursor above" })
      set({ "n", "x" }, "<C-Down>", function()
        mc.lineAddCursor(1)
      end, { desc = "Add cursor below" })
      set({ "n", "x" }, "<leader>cA", mc.matchAllAddCursors, { desc = "Add cursor at all matches" })
      set("n", "<C-LeftMouse>", mc.handleMouse)
      mc.addKeymapLayer(function(layer)
        layer({ "n", "x" }, "<left>", mc.prevCursor)
        layer({ "n", "x" }, "<right>", mc.nextCursor)
        layer({ "n", "x" }, "<C-q>", function()
          mc.matchSkipCursor(1)
        end)
        layer({ "n", "x" }, "<C-x>", mc.deleteCursor)
        layer("n", "<esc>", function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)
      end)
      local hl = vim.api.nvim_set_hl
      hl(0, "MultiCursorCursor", { reverse = true })
      hl(0, "MultiCursorVisual", { link = "Visual" })
      hl(0, "MultiCursorSign", { link = "SignColumn" })
      hl(0, "MultiCursorMatchPreview", { link = "Search" })
      hl(0, "MultiCursorDisabledCursor", { reverse = true })
      hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
      hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end,
  },

  {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next todo",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous todo",
      },
      {
        "<leader>ft",
        function()
          Snacks.picker.todo_comments()
        end,
        desc = "Find todos",
      },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todos (Trouble)" },
    },
  },

  {
    -- native gc/gcc commenting with the correct commentstring in tsx/svelte/html
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "VeryLazy",
    opts = { enable_autocmd = false },
    init = function()
      vim.g.skip_ts_context_commentstring_module = true
    end,
    config = function(_, opts)
      require("ts_context_commentstring").setup(opts)
      local get_option = vim.filetype.get_option
      vim.filetype.get_option = function(filetype, option)
        return option == "commentstring" and require("ts_context_commentstring.internal").calculate_commentstring()
          or get_option(filetype, option)
      end
    end,
  },

  {
    -- edit a directory like a buffer (rename/move/delete files with normal vim editing)
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      default_file_explorer = true,
      view_options = { show_hidden = true },
      keymaps = {
        ["q"] = "actions.close",
        -- keep <C-h/j/k/l> for vim-tmux-navigator (oil binds <C-h> to split-open and <C-l> to refresh)
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<C-s>"] = { "actions.select", opts = { horizontal = true }, desc = "Open in horizontal split" },
        ["gr"] = "actions.refresh",
      },
    },
    keys = { { "-", "<cmd>Oil<cr>", desc = "Open parent directory (oil)" } },
    config = function(_, opts)
      require("oil").setup(opts)
      -- keep LSP imports in sync when files are moved in oil
      vim.api.nvim_create_autocmd("User", {
        pattern = "OilActionsPost",
        callback = function(event)
          if event.data.actions.type == "move" then
            Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
          end
        end,
      })
    end,
  },

  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      auto_save = true,
      auto_restore = false, -- restore explicitly: dashboard `s` or <leader>wr
      suppressed_dirs = { "~/", "~/Downloads", "/" },
    },
    keys = {
      { "<leader>wr", "<cmd>AutoSession restore<cr>", desc = "Restore session for cwd" },
      { "<leader>ws", "<cmd>AutoSession save<cr>", desc = "Save session" },
      { "<leader>wf", "<cmd>AutoSession search<cr>", desc = "Find session" },
    },
  },

  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (workspace)" },
      { "<leader>xw", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (workspace)" },
      { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnostics (file)" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols" },
      {
        "<leader>xL",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP references / definitions",
      },
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "mdx" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = { file_types = { "markdown", "mdx" }, completions = { blink = { enabled = true } } },
  },
}
