-- LSP servers installed by mason and enabled automatically by mason-lspconfig (v2).
-- Per-server overrides live in ~/.config/nvim/lsp/<name>.lua (native vim.lsp.config).
local mason_servers = {
  "lua_ls",
  "tofu_ls", -- OpenTofu language server
  "powershell_es",
  "basedpyright",
  "yamlls",
  "jsonls",
  "taplo",
  "bashls",
  "dockerls",
  "marksman",
  "bicep",
  "lemminx",
  -- web
  "ts_ls",
  "html",
  "cssls",
  "tailwindcss",
  "svelte",
  "emmet_ls",
  "graphql",
  "prismals",
}

-- servers that come from mise / PATH instead of mason
local path_servers = { "ruff" }

-- formatters, linters, debuggers installed by mason (linters from brew: shellcheck, hadolint, actionlint, zizmor)
local mason_tools = {
  "stylua",
  "prettier",
  "shfmt",
  "csharpier",
  "roslyn", -- C# (Crashdummyy registry)
  "netcoredbg",
  "debugpy",
  "markdownlint-cli2",
  "eslint_d",
}

return {
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall", "MasonLog" },
    build = ":MasonUpdate",
    opts = {
      registries = { "github:mason-org/mason-registry", "github:Crashdummyy/mason-registry" },
      ui = {
        border = "rounded",
        icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" },
      },
    },
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    event = "VeryLazy",
    cmd = { "MasonToolsInstall", "MasonToolsInstallSync", "MasonToolsUpdate", "MasonToolsClean" },
    opts = { ensure_installed = mason_tools, run_on_start = true },
  },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },

  { "b0o/schemastore.nvim", lazy = true },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      { "mason-org/mason-lspconfig.nvim", opts = { ensure_installed = mason_servers, automatic_enable = true } },
      "saghen/blink.cmp",
      "b0o/schemastore.nvim",
    },
    config = function()
      vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })
      -- mason-lspconfig points bundle_path one directory too high for the mason package layout;
      -- an explicit vim.lsp.config() call takes precedence over every lsp/*.lua file.
      vim.lsp.config("powershell_es", {
        bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services/PowerShellEditorServices",
      })
      vim.lsp.enable(path_servers)

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("phant0mw0lf_lsp", { clear = true }),
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if client and client.name == "ruff" then
            client.server_capabilities.hoverProvider = false -- basedpyright owns hover
          end

          local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
          end
          map("n", "gR", function()
            Snacks.picker.lsp_references()
          end, "References")
          map("n", "gD", vim.lsp.buf.declaration, "Declaration")
          map("n", "gd", function()
            Snacks.picker.lsp_definitions()
          end, "Definitions")
          map("n", "gi", function()
            Snacks.picker.lsp_implementations()
          end, "Implementations")
          map("n", "gt", function()
            Snacks.picker.lsp_type_definitions()
          end, "Type definitions")
          map("n", "K", vim.lsp.buf.hover, "Hover documentation")
          map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          map("n", "<leader>rs", "<cmd>LspRestart<CR>", "Restart LSP")
          map("n", "<leader>cs", function()
            Snacks.picker.lsp_symbols()
          end, "Document symbols")
          map("n", "<leader>cS", function()
            Snacks.picker.lsp_workspace_symbols()
          end, "Workspace symbols")
          map("n", "<leader>ci", "<cmd>checkhealth vim.lsp<CR>", "LSP info")
          map("n", "<leader>D", function()
            Snacks.picker.diagnostics_buffer()
          end, "Buffer diagnostics")
          map("n", "<leader>d", vim.diagnostic.open_float, "Line diagnostics")
          map("n", "[d", function()
            vim.diagnostic.jump({ count = -1, float = true })
          end, "Previous diagnostic")
          map("n", "]d", function()
            vim.diagnostic.jump({ count = 1, float = true })
          end, "Next diagnostic")
        end,
      })
    end,
  },

  -- C# via the Roslyn language server (same engine as VS Code's C# Dev Kit)
  { "seblyng/roslyn.nvim", ft = { "cs" }, opts = {} },
}
