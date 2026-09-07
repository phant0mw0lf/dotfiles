local function augroup(name)
  return vim.api.nvim_create_augroup("phant0mw0lf_" .. name, { clear = true })
end

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("yank"),
  callback = function()
    vim.hl.on_yank({ timeout = 150 })
  end,
})

-- reload buffers changed outside nvim (needs tmux focus-events on)
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- restore cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("restore_cursor"),
  callback = function(ev)
    local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
    local lcount = vim.api.nvim_buf_line_count(ev.buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- equalise splits when the terminal is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup("resize_splits"),
  callback = function()
    local tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. tab)
  end,
})

-- q closes helper windows
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "help",
    "qf",
    "man",
    "checkhealth",
    "notify",
    "lspinfo",
    "git",
    "dap-float",
    "neotest-output",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(ev)
    vim.bo[ev.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = ev.buf, silent = true })
  end,
})

-- prose filetypes: wrap + spell
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("prose"),
  pattern = { "markdown", "mdx", "gitcommit", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- don't continue comments on `o`
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("formatoptions"),
  callback = function()
    vim.opt_local.formatoptions:remove("o")
  end,
})

-- create missing parent directories on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("auto_mkdir"),
  callback = function(ev)
    if ev.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    vim.fn.mkdir(vim.fn.fnamemodify(ev.match, ":p:h"), "p")
  end,
})
