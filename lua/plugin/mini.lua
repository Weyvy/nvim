vim.pack.add({
	{
		src = "https://github.com/nvim-mini/mini.nvim",
		name = "mini.nvim",
	},
})

require("mini.ai").setup({
	-- Avoid conflicts with built-in incremental selection mappings on Neovim >= 0.12
	mappings = {
		around_next = "aa",
		inside_next = "ii",
	},
	n_lines = 500,
})

require('mini.surround').setup()

require("mini.pairs").setup()

local statusline = require("mini.statusline")

statusline.setup({
	use_icons = vim.g.have_nerd_font,
})

---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function()
	return "%2l:%-2v"
end