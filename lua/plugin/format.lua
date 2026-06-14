vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "lua", "javascript", "typescript", "json", "yaml", "html", "css" },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.expandtab = true
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "go" },
	callback = function()
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.expandtab = false
	end,
})

vim.pack.add({
	{
		src = "https://github.com/stevearc/conform.nvim",
		name = "conform.nvim",
	},
})

local conform = require("conform")

conform.setup({
	notify_on_error = false,

	format_on_save = function(bufnr)
		local disable_filetypes = {}

		return {
			lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
			timeout_ms = 500,
		}
	end,

	formatters_by_ft = {
		zig = { "zigfmt" },
		lua = { "stylua" },
		python = { "black" },
		javascript = { "prettier" },
		go = { "gofmt" },
		c = { "clang-format" },
		cpp = { "clang-format" },
	},
})

vim.keymap.set({ "n", "v" }, "<leader>p", function()
	conform.format({
		async = true,
		lsp_fallback = true,
	})
end, {
	desc = "[F]ormat buffer",
})

