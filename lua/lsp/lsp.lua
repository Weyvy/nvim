vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		local builtin = require("telescope.builtin")

		map("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
		map("gi", builtin.lsp_implementations, "[G]oto [I]mplementation")
		map("gr", builtin.lsp_references, "[G]oto [R]eferences")
		map("gD", builtin.lsp_type_definitions, "[G]oto Type [D]efinition")

		map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		map("K", vim.lsp.buf.hover, "Hover Documentation")
		map("<leader>k", vim.lsp.buf.signature_help, "Signature Documentation")
		map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
		map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

		local client = vim.lsp.get_client_by_id(event.data.client_id)

		if client then
			client.server_capabilities.semanticTokensProvider = nil

			pcall(vim.lsp.semantic_tokens.enable, false, {
				bufnr = event.buf,
				client_id = client.id,
			})
		end

		if client and client:supports_method("textDocument/documentHighlight", event.buf) then
			local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })

			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({
						group = "kickstart-lsp-highlight",
						buffer = event2.buf,
					})
				end,
			})
		end

		if client and client:supports_method("textDocument/inlayHint", event.buf) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "[T]oggle Inlay [H]ints")
		end
	end,
})

vim.pack.add({
	{
		src = "https://github.com/neovim/nvim-lspconfig",
		name = "nvim-lspconfig",
	},
	{
		src = "https://github.com/folke/lazydev.nvim",
		name = "lazydev.nvim",
	},
})

require("lazydev").setup({
	library = {
		{
			path = "${3rd}/luv/library",
			words = { "vim%.uv" },
		},
	},
})

vim.lsp.config("gopls", {
	settings = {
		gopls = {
			gofumpt = true,
			staticcheck = true,
		},
	},
})
vim.lsp.enable("gopls")

vim.lsp.config("pyright", {
	settings = nil,
})
vim.lsp.enable("pyright")

vim.lsp.config("lua_ls", {
	settings = nil,
})
vim.lsp.enable("lua_ls")

vim.lsp.config("zls", {
	settings = nil,
})
vim.lsp.enable("zls")

vim.lsp.config("clangd", {
	cmd = {
		"clangd",
		"--compile-commands-dir=build",
	},
})
vim.lsp.enable("clangd")

vim.lsp.config("tsserver", {
	settings = nil,
})
vim.lsp.enable("tsserver")

vim.lsp.config("rust_analyzer", {
	settings = nil,
})
vim.lsp.enable("rust_analyzer")
