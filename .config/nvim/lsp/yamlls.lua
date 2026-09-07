return {
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
      schemaStore = { enable = false, url = "" }, -- schemastore.nvim provides the catalog
      schemas = require("schemastore").yaml.schemas(),
      validate = true,
      keyOrdering = false,
      format = { enable = false }, -- prettier via conform
    },
  },
}
