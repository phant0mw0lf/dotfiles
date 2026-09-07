-- bundle_path is set in plugins/lsp.lua (must win over mason-lspconfig's lsp/powershell_es.lua).
return {
  shell = "pwsh",
  settings = {
    powershell = {
      codeFormatting = { Preset = "OTBS", AutoCorrectAliases = true, UseCorrectCasing = true },
      scriptAnalysis = { enable = true },
    },
  },
}
