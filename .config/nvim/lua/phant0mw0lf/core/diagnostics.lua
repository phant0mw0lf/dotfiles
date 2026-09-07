local sev = vim.diagnostic.severity

-- inline diagnostics (ErrorLens equivalent); nvim >= 0.11 disables virtual_text by default
vim.diagnostic.config({
  virtual_text = { spacing = 2, source = "if_many", prefix = "●" },
  signs = {
    text = {
      [sev.ERROR] = " ",
      [sev.WARN] = " ",
      [sev.HINT] = "󰠠 ",
      [sev.INFO] = " ",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
})
