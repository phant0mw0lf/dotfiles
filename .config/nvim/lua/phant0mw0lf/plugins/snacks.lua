-- snacks.nvim replaces telescope, alpha, dressing, lazygit.nvim, vim-maximizer,
-- nvim-tree and indent-blankline from the previous setup.
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        header = [[
  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        keys = {
          { icon = " ", key = "f", desc = "Find file", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New file", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "e", desc = "Explorer", action = ":lua Snacks.explorer()" },
          { icon = " ", key = "s", desc = "Restore session", section = "session" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "M", desc = "Mason", action = ":Mason" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "recent_files", icon = " ", title = "Recent files", indent = 2, padding = 1 },
        { section = "projects", icon = " ", title = "Projects", indent = 2, padding = 1 },
        { section = "startup" },
      },
    },
    explorer = { enabled = true, replace_netrw = false },
    indent = { enabled = true, indent = { char = "┊" }, scope = { char = "┊" } },
    input = { enabled = true },
    notifier = { enabled = true, timeout = 3000 },
    picker = {
      enabled = true,
      win = {
        input = {
          keys = {
            ["<C-j>"] = { "list_down", mode = { "i", "n" } },
            ["<C-k>"] = { "list_up", mode = { "i", "n" } },
            ["<C-q>"] = { "qflist", mode = { "i", "n" } },
          },
        },
      },
      sources = {
        explorer = { hidden = true, ignored = true, exclude = { ".DS_Store", ".git" } },
        files = { hidden = true },
        grep = { hidden = true },
      },
    },
    quickfile = { enabled = true },
    scope = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    lazygit = { configure = true },
    zen = { toggles = { dim = false } },
  },
  keys = {
    -- explorer (VS Code ctrl+e; a=add r=rename d=delete c=copy m=move y=yank p=paste inside)
    {
      "<C-e>",
      function()
        Snacks.explorer()
      end,
      desc = "Toggle explorer",
    },
    {
      "<leader>ee",
      function()
        Snacks.explorer()
      end,
      desc = "Toggle explorer",
    },
    {
      "<leader>ef",
      function()
        Snacks.explorer.reveal()
      end,
      desc = "Reveal current file in explorer",
    },
    -- find
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Find files",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.recent()
      end,
      desc = "Recent files",
    },
    {
      "<leader>fs",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep in cwd",
    },
    {
      "<leader>fc",
      function()
        Snacks.picker.grep_word()
      end,
      desc = "Grep word under cursor / selection",
      mode = { "n", "x" },
    },
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.git_files()
      end,
      desc = "Git files",
    },
    {
      "<leader>fh",
      function()
        Snacks.picker.help()
      end,
      desc = "Help pages",
    },
    {
      "<leader>fk",
      function()
        Snacks.picker.keymaps()
      end,
      desc = "Keymaps",
    },
    {
      "<leader>fp",
      function()
        Snacks.picker.projects()
      end,
      desc = "Projects",
    },
    {
      "<leader>fd",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "Diagnostics (workspace)",
    },
    {
      "<leader>fu",
      function()
        Snacks.picker.undo()
      end,
      desc = "Undo history",
    },
    {
      "<leader>f:",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Command history",
    },
    {
      "<leader>fR",
      function()
        Snacks.picker.resume()
      end,
      desc = "Resume last picker",
    },
    {
      "<leader>ld",
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = "Diagnostics (file)",
    },
    {
      "<leader>lw",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "Diagnostics (workspace)",
    },
    -- git
    {
      "<leader>lg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>gg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>gl",
      function()
        Snacks.picker.git_log()
      end,
      desc = "Git log",
    },
    {
      "<leader>gf",
      function()
        Snacks.picker.git_log_file()
      end,
      desc = "Git log (file)",
    },
    {
      "<leader>gb",
      function()
        Snacks.picker.git_branches()
      end,
      desc = "Git branches",
    },
    {
      "<leader>gs",
      function()
        Snacks.picker.git_status()
      end,
      desc = "Git status",
    },
    {
      "<leader>gB",
      function()
        Snacks.gitbrowse()
      end,
      desc = "Open in GitHub",
      mode = { "n", "v" },
    },
    -- windows / buffers
    {
      "<leader>sm",
      function()
        Snacks.zen.zoom()
      end,
      desc = "Maximise / restore split",
    },
    {
      "<leader>Q",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete buffer (keep window)",
    },
    {
      "<leader>N",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "Notification history",
    },
    {
      "<c-/>",
      function()
        Snacks.terminal()
      end,
      desc = "Toggle terminal",
      mode = { "n", "t" },
    },
    {
      "<c-_>",
      function()
        Snacks.terminal()
      end,
      desc = "Toggle terminal",
      mode = { "n", "t" },
    },
    {
      "]]",
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = "Next reference",
      mode = { "n", "t" },
    },
    {
      "[[",
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = "Prev reference",
      mode = { "n", "t" },
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative number" }):map("<leader>uL")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.dim():map("<leader>uD")
        Snacks.toggle
          .new({
            name = "Format on save",
            get = function()
              return vim.g.autoformat ~= false
            end,
            set = function(state)
              vim.g.autoformat = state
            end,
          })
          :map("<leader>uf")
      end,
    })
  end,
}
