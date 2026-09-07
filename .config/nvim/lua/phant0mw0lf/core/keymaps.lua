local map = vim.keymap.set

map("", "<Space>", "<Nop>")

-- general
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>confirm quit<CR>", { desc = "Close window" })
map("n", "<leader>x", "<cmd>x<CR>", { desc = "Save and close" })
map("n", "<leader>nh", "<cmd>nohl<CR>", { desc = "Clear search highlights" })
map("n", "<Esc>", "<cmd>nohl<CR><Esc>", { desc = "Clear search highlights" })
map("n", "<leader>+", "<C-a>", { desc = "Increment number" })
map("n", "<leader>-", "<C-x>", { desc = "Decrement number" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- keep cursor centred while jumping
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- move lines, keep selection when indenting
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("v", "<", "<gv")
map("v", ">", ">gv")
map("x", "<leader>p", '"_dP', { desc = "Paste without yanking selection" })

-- splits
map("n", "<leader>sv", "<C-w>v", { desc = "Split vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Equalise splits" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close split" })

-- tabs
map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close tab" })
map("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Next tab" })
map("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Previous tab" })
map("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open buffer in new tab" })
