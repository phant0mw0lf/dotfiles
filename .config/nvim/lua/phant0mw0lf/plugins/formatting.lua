return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true })
      end,
      mode = { "n", "v" },
      desc = "Format file or selection",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff_organize_imports", "ruff_format" },
      terraform = { "tofu_fmt" },
      ["terraform-vars"] = { "tofu_fmt" },
      opentofu = { "tofu_fmt" },
      hcl = { "terragrunt_hclfmt" },
      cs = { "csharpier" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      zsh = { "shfmt" },
      toml = { "taplo" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      svelte = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      jsonc = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      graphql = { "prettier" },
      -- ps1: PowerShellEditorServices formats via LSP fallback
    },
    default_format_opts = { lsp_format = "fallback" },
    format_on_save = function(bufnr)
      if vim.g.autoformat == false or vim.b[bufnr].autoformat == false then
        return
      end
      return { timeout_ms = 2000, lsp_format = "fallback" }
    end,
    formatters = {
      shfmt = { prepend_args = { "-i", "2", "-ci" } },
    },
  },
}
