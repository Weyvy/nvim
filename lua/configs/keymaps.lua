vim.keymap.set(
  "n",
  "<leader>vr",
  function()
    vim.cmd("source $MYVIMRC")
    print("Neovim config reloaded")
  end,
  { desc = "reload Neovim config" }
)