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