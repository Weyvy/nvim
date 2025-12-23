return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "cpp",
      "dockerfile",
      "go",
      "html",
      "http",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "toml",
      "vimdoc",
      "yaml",
      "help",
    },
    auto_install = true,
    sync_install = true,
    highlight = {
      enable = true,
    },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<Enter>",
        node_incremental = "<Enter>",
        scope_incremtal = false,
        node_decremental = "<Backspace>",
      },
    },
  }
}
