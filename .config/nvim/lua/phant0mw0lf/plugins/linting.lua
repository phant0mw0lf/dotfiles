return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      terraform = { "tflint" },
      yaml = { "yamllint" },
      markdown = { "markdownlint-cli2" },
      dockerfile = { "hadolint" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      -- python: ruff LSP; sh/bash: bashls runs shellcheck itself; ps1: PSScriptAnalyzer via LSP
    }

    local function is_workflow(bufnr)
      return vim.api.nvim_buf_get_name(bufnr):match("%.github/workflows/[^/]+%.ya?ml$") ~= nil
    end

    local function lint_buffer()
      lint.try_lint()
      if is_workflow(0) then
        lint.try_lint({ "actionlint", "zizmor" })
      end
    end

    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("phant0mw0lf_lint", { clear = true }),
      callback = lint_buffer,
    })

    vim.keymap.set("n", "<leader>l", lint_buffer, { desc = "Lint current file" })
  end,
}
