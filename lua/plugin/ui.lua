vim.pack.add({
	{
		src = "https://github.com/NMAC427/guess-indent.nvim",
		name = "guess-indent.nvim",
	},
})
require("guess-indent").setup({})

if vim.g.have_nerd_font then
	vim.pack.add({
		{
			src = "https://github.com/nvim-tree/nvim-web-devicons",
			name = "nvim-web-devicons",
		},
	})
end

vim.pack.add({
	{
		src = "https://github.com/lewis6991/gitsigns.nvim",
		name = "gitsigns.nvim",
	},
})
require("gitsigns").setup({
	signs = {
		add = { text = "+" }, ---@diagnostic disable-line: missing-fields
		change = { text = "~" }, ---@diagnostic disable-line: missing-fields
		delete = { text = "_" }, ---@diagnostic disable-line: missing-fields
		topdelete = { text = "‾" }, ---@diagnostic disable-line: missing-fields
		changedelete = { text = "~" }, ---@diagnostic disable-line: missing-fields
	},
})


vim.pack.add({
	{
		src = "https://github.com/folke/todo-comments.nvim",
		name = "todo-comments.nvim",
	},
})
require("todo-comments").setup({
	signs = false,
})


vim.pack.add({
	{
		src = "https://github.com/m4xshen/smartcolumn.nvim",
		name = "smartcolumn.nvim",
	},
})
require("smartcolumn").setup({
	colorcolumn = "100",
	scope = "file",
	disabled_filetypes = { "help", "text", "markdown" },
})

vim.pack.add({
	{
		src = "https://github.com/j-hui/fidget.nvim",
		name = "fidget.nvim",
	},
})
require("fidget").setup({})


vim.pack.add({
	{
		src = "https://github.com/rrethy/vim-illuminate",
		name = "vim-illuminate",
	},
})
require("illuminate").configure()

vim.pack.add({
	{
		src = "https://github.com/tpope/vim-sleuth",
		name = "vim-sleuth",
	},
})


vim.pack.add({
	{
		src = "https://github.com/xzbdmw/colorful-menu.nvim",
		name = "colorful-menu.nvim",
	},
})
require("colorful-menu").setup({
	ls = {
		lua_ls = {
			arguments_hl = "@comment",
		},

		gopls = {
			align_type_to_right = true,
			add_colon_before_type = false,
			preserve_type_when_truncate = true,
		},

		ts_ls = {
			extra_info_hl = "@comment",
		},

		vtsls = {
			extra_info_hl = "@comment",
		},

		["rust-analyzer"] = {
			extra_info_hl = "@comment",
			align_type_to_right = true,
			preserve_type_when_truncate = true,
		},

		clangd = {
			extra_info_hl = "@comment",
			align_type_to_right = true,
			import_dot_hl = "@comment",
			preserve_type_when_truncate = true,
		},

		zls = {
			align_type_to_right = true,
		},

		basedpyright = {
			extra_info_hl = "@comment",
		},

		pyright = {
			extra_info_hl = "@comment",
		},

		pylsp = {
			extra_info_hl = "@comment",
			arguments_hl = "@comment",
		},

		fallback = true,
		fallback_extra_info_hl = "@comment",
	},

	fallback_highlight = "@variable",
	max_width = 60,
})

vim.pack.add({
	{
		src = "https://github.com/lukas-reineke/indent-blankline.nvim",
		name = "indent-blankline.nvim",
	},
})

require("ibl").setup({
	indent = {
		char = "│",
		tab_char = "│", -- important for Go tabs
	},
})

require("plugin.colorscheme")
