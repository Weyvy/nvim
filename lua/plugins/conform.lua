return  {
    "stevearc/conform.nvim",
    lazy = false,
    keys = {
      {
        "<leader>p",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "[F]ormat buffer",
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = {}
        return {
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        javascript = { "prettier" },
        go = { "gofmt" },
        c = { "clang-format" },
        cpp = { "clang-format" },
      },
    },
}