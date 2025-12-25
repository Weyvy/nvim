return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
  },
  config = function()
    local ufo = require("ufo")
    ufo.setup({
      provider_selector = function(_, _, _)
        return { "treesitter", "indent" }
      end,
      preview = {
        mappings = {
          scrollU = '<C-u>',
          scrollD = '<C-d>',
          jumpTop = '[',
          jumpBot = ']'
        }
      },
    })

    vim.keymap.set('n', 'zR', ufo.openAllFolds, { desc = "Open all folds" })
    vim.keymap.set('n', 'zM', ufo.closeAllFolds, { desc = "Close all folds" })
    vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
    vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
    vim.keymap.set('n', 'K', function()
      local winid = require('ufo').peekFoldedLinesUnderCursor()
      if not winid then
        vim.lsp.buf.hover()
      end
    end)
  end,
}
