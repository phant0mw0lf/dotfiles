return {
  settings = {
    basedpyright = {
      disableOrganizeImports = true, -- ruff does it
      analysis = { typeCheckingMode = "standard", diagnosticMode = "openFilesOnly" },
    },
  },
}
