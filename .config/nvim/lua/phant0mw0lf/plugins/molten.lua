-- Jupyter in nvim. .ipynb files are converted to markdown by jupytext on open and written back on save;
-- molten runs cells against a kernel. Needs the python host venv (see options.lua) and `jupytext` on PATH.
-- Alacritty has no image protocol, so plots are not rendered inline (image_provider = "none").
return {
  {
    "GCBallesteros/jupytext.nvim",
    lazy = false,
    opts = { style = "markdown", output_extension = "md", force_ft = "markdown" },
  },
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    build = ":UpdateRemotePlugins",
    ft = { "markdown", "python" },
    init = function()
      vim.g.molten_image_provider = "none"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = false
      vim.g.molten_virt_text_output = true
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_lines_off_by_1 = true
    end,
    keys = {
      { "<leader>mi", "<cmd>MoltenInit<cr>", desc = "Init kernel" },
      { "<leader>me", "<cmd>MoltenEvaluateOperator<cr>", desc = "Evaluate operator" },
      { "<leader>ml", "<cmd>MoltenEvaluateLine<cr>", desc = "Evaluate line" },
      { "<leader>mr", "<cmd>MoltenReevaluateCell<cr>", desc = "Re-evaluate cell" },
      { "<leader>me", ":<C-u>MoltenEvaluateVisual<cr>gv", mode = "v", desc = "Evaluate selection" },
      { "<leader>mo", "<cmd>noautocmd MoltenEnterOutput<cr>", desc = "Enter output window" },
      { "<leader>mh", "<cmd>MoltenHideOutput<cr>", desc = "Hide output" },
      { "<leader>md", "<cmd>MoltenDelete<cr>", desc = "Delete cell" },
      { "<leader>mx", "<cmd>MoltenInterrupt<cr>", desc = "Interrupt kernel" },
      { "<leader>mR", "<cmd>MoltenRestart!<cr>", desc = "Restart kernel" },
    },
  },
}
