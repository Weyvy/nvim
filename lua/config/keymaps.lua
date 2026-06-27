vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "]b", "<cmd>bnext<CR>", {
	desc = "Next buffer",
})

vim.keymap.set("n", "[b", "<cmd>bprevious<CR>", {
	desc = "Previous buffer",
})

vim.keymap.set("n", "gl", vim.diagnostic.open_float, {
	desc = "Show diagnostic message",
})

vim.keymap.set("n", "<Tab>", "<C-^>", { desc = "Alternate buffer" })

-- Center cursor after vertical navigation
vim.keymap.set("n", "j", "jzz", { desc = "Move down and center" })
vim.keymap.set("n", "k", "kzz", { desc = "Move up and center" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up and center" })

vim.keymap.set("n", "<C-f>", "<C-f>zz", { desc = "Page down and center" })
vim.keymap.set("n", "<C-b>", "<C-b>zz", { desc = "Page up and center" })

vim.keymap.set("n", "G", "Gzz", { desc = "Go to end and center" })
vim.keymap.set("n", "gg", "ggzz", { desc = "Go to top and center" })

vim.keymap.set("n", "{", "{zz", { desc = "Previous paragraph and center" })
vim.keymap.set("n", "}", "}zz", { desc = "Next paragraph and center" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result and center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result and center" })
