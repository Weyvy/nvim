vim.keymap.set(
  "n",
  "<leader>vr",
  function()
    vim.cmd("source $MYVIMRC")
    print("Neovim config reloaded")
  end,
  { desc = "reload Neovim config" }
)

vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })



vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
vim.keymap.set("n", "gd", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })
vim.keymap.set("n", "gi", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
vim.keymap.set("n", "go", "<C-o>", { desc = "Go back (out)" })
vim.keymap.set("n", "gb", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "gn", ":bnext<CR>", { desc = "Next buffer" })
