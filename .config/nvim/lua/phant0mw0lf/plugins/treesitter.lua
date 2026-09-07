local parsers = require("phant0mw0lf.treesitter_parsers")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({})
      require("nvim-treesitter").install(parsers)

      -- filetypes that reuse another parser
      vim.treesitter.language.register("markdown", "mdx")
      vim.treesitter.language.register("terraform", { "terraform-vars", "opentofu", "opentofu-vars" })

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("phant0mw0lf_treesitter", { clear = true }),
        callback = function(ev)
          if pcall(vim.treesitter.start, ev.buf) then
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup({ select = { lookahead = true }, move = { set_jumps = true } })
      local select = require("nvim-treesitter-textobjects.select")
      local move = require("nvim-treesitter-textobjects.move")
      local function sel(lhs, query, desc)
        vim.keymap.set({ "x", "o" }, lhs, function()
          select.select_textobject(query, "textobjects")
        end, { desc = desc })
      end
      sel("af", "@function.outer", "a function")
      sel("if", "@function.inner", "inner function")
      sel("ac", "@class.outer", "a class")
      sel("ic", "@class.inner", "inner class")
      sel("aa", "@parameter.outer", "a parameter")
      sel("ia", "@parameter.inner", "inner parameter")
      sel("ab", "@block.outer", "a block")
      sel("ib", "@block.inner", "inner block")
      vim.keymap.set({ "n", "x", "o" }, "]f", function()
        move.goto_next_start("@function.outer", "textobjects")
      end, { desc = "Next function" })
      vim.keymap.set({ "n", "x", "o" }, "[f", function()
        move.goto_previous_start("@function.outer", "textobjects")
      end, { desc = "Previous function" })
      vim.keymap.set({ "n", "x", "o" }, "]a", function()
        move.goto_next_start("@parameter.inner", "textobjects")
      end, { desc = "Next parameter" })
      vim.keymap.set({ "n", "x", "o" }, "[a", function()
        move.goto_previous_start("@parameter.inner", "textobjects")
      end, { desc = "Previous parameter" })
    end,
  },

  {
    -- sticky scroll
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    opts = { max_lines = 4, multiline_threshold = 2 },
    keys = {
      {
        "<leader>ut",
        function()
          require("treesitter-context").toggle()
        end,
        desc = "Toggle sticky context",
      },
    },
  },

  { "windwp/nvim-ts-autotag", event = { "BufReadPre", "BufNewFile" }, opts = {} },
}
