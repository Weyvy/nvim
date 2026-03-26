return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
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
    indent = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<Enter>",
        node_incremental = "<Enter>",
        scope_incremental = false,
        node_decremental = "<Backspace>",
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["ab"] = "@block.outer",
          ["ib"] = "@block.inner",
        },
        selection_modes = {
          ["@function.outer"] = "V",
          ["@function.inner"] = "V",
          ["@class.outer"] = "V",
          ["@class.inner"] = "V",
          ["@block.outer"] = "V",
          ["@block.inner"] = "V",
        },
      },
    },
  },
}
