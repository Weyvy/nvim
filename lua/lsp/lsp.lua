vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    -- NOTE: Remember that Lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end


		-- Go to definition
		map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")

		-- Go to declaration
		map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

		-- Go to implementation
		map("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")

		-- Go to references
		map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")

		-- Hover documentation
		map("K", vim.lsp.buf.hover, "Hover Documentation")

		-- Signature help
		map("<leader>k", vim.lsp.buf.signature_help, "Signature Documentation")

		-- Rename symbol
		map("grn", vim.lsp.buf.rename, "[R]e[n]ame")

		-- Code action
		map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })


    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method('textDocument/documentHighlight', event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    -- The following code creates a keymap to toggle inlay hints in your
    -- code, if the language server you are using supports them
    --
    -- This may be unwanted, since they displace some of your code
    if client and client:supports_method('textDocument/inlayHint', event.buf) then
      map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
    end
  end,
})

vim.pack.add({
	{
		src = "https://github.com/neovim/nvim-lspconfig",
		name = "nvim-lspconfig",
	},
})

vim.pack.add({
	{
		src = "https://github.com/folke/lazydev.nvim",
		name = "lazydev.nvim",
	},
})
require("lazydev").setup({
	library = {
		-- Load luvit types when the `vim.uv` word is found
		{
			path = "${3rd}/luv/library",
			words = { "vim%.uv" },
		},
	},
})

vim.lsp.enable('gopls')
vim.lsp.config('gopls', {
  settings = nil
})

vim.lsp.enable('pyright')
vim.lsp.config('pyright', {
  settings = nil,
})

vim.lsp.enable('lua_ls')
vim.lsp.config('lua_ls', {
  settings = nil,
})

vim.lsp.enable('zls')
vim.lsp.config('zls', {
  settings = nil,
})

vim.lsp.enable('clangd')
vim.lsp.config('clangd', {
  settings = nil,
})

vim.lsp.enable('tsserver')
vim.lsp.config('tsserver', {
  settings = nil,
})

vim.lsp.enable('rust_analyzer')
vim.lsp.config('rust_analyzer', {
  settings = nil,
})
