local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.autoformat = true -- conform format-on-save, toggle with <leader>uf

-- python host for remote plugins (molten). Created by install.sh:
--   uv venv ~/.local/share/nvim/venv && uv pip install --python ~/.local/share/nvim/venv/bin/python pynvim jupyter_client
local venv_python = vim.fn.expand("~/.local/share/nvim/venv/bin/python")
if vim.uv.fs_stat(venv_python) then
  vim.g.python3_host_prog = venv_python
end

-- ui
opt.cmdheight = 0
opt.scrolloff = 10
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.background = "dark"
opt.showmode = false -- lualine shows the mode
opt.winborder = "rounded"
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.splitright = true
opt.splitbelow = true
opt.confirm = true
opt.mouse = "a"
opt.inccommand = "split"

-- tabs & indentation (editorconfig overrides per project)
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- wrapping
opt.wrap = true
opt.linebreak = true
opt.breakindent = true

-- search
opt.ignorecase = true
opt.smartcase = true

-- folds (treesitter)
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldtext = ""

-- files
opt.swapfile = false
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 250
opt.timeoutlen = 400
opt.backspace = "indent,eol,start"
opt.clipboard:append("unnamedplus")
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
opt.spelllang = { "en", "de" }

-- filetypes
vim.filetype.add({
  extension = {
    mdx = "mdx",
    tofu = "opentofu",
    tfvars = "terraform-vars",
  },
  filename = {
    ["terragrunt.hcl"] = "hcl",
    ["root.hcl"] = "hcl",
  },
})
