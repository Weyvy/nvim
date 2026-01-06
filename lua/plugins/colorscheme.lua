return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      no_italic = true,
      term_colors = true,
      transparent_background = false,
      styles = {
        comments = {},
        conditionals = {},
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
      },
      color_overrides = {
        mocha = {
          base = "#000000",
          mantle = "#000000",
          crust = "#000000",
        },
      },
      integrations = {
        treesitter = true,
        telescope = true,
        which_key = true,
        blink_cmp = true,
        leap = true,
        copilot_vim = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    branch = "master",
    config = function()
      require('kanagawa').setup({
        transparent = true,
        overrides = function(colors)
          return {
            ["@markup.link.url.markdown_inline"] = { link = "Special" },      -- (url)
            ["@markup.link.label.markdown_inline"] = { link = "WarningMsg" }, -- [label]
            ["@markup.italic.markdown_inline"] = { link = "Exception" },      -- *italic*
            ["@markup.raw.markdown_inline"] = { link = "String" },            -- `code`
            ["@markup.list.markdown"] = { link = "Function" },                -- + list
            ["@markup.quote.markdown"] = { link = "Error" },                  -- > blockcode
            ["@markup.list.checked.markdown"] = { link = "WarningMsg" }       -- - [X] checked list item
          }
        end
      });
    end,
  },
  {
    "metalelf0/base16-black-metal-scheme",
    config = function(_, opts)
    end,
  },
  {
    "Mofiqul/vscode.nvim",
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      vim.cmd.colorscheme("vscode")
    end,
  },
  {
    "sainnhe/everforest",
    priority = 1000,
    config = function()
      vim.g.everforest_background = "medium"
      vim.g.everforest_enable_italic = 1
      vim.cmd.colorscheme("everforest")
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      vim.cmd.colorscheme("gruvbox")
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "rose-pine/neovim",
  },
  {
    'doums/darcula'
  },
  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('nordic').load()
    end
  },
  {
    'Shatur/neovim-ayu'
  },
  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme'
  },
  {
    "arturgoms/moonbow.nvim"
  }
}
