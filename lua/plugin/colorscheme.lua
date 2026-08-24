vim.pack.add({
	{
		src = "https://github.com/catppuccin/nvim",
		name = "catppuccin",
	},
	{
		src = "https://github.com/rebelot/kanagawa.nvim",
		name = "kanagawa.nvim",
	},
	{
		src = "https://github.com/metalelf0/base16-black-metal-scheme",
		name = "base16-black-metal-scheme",
	},
	{
		src = "https://github.com/Mofiqul/vscode.nvim",
		name = "vscode.nvim",
	},
	{
		src = "https://github.com/sainnhe/everforest",
		name = "everforest",
	},
	{
		src = "https://github.com/ellisonleao/gruvbox.nvim",
		name = "gruvbox.nvim",
	},
	{
		src = "https://github.com/folke/tokyonight.nvim",
		name = "tokyonight.nvim",
	},
	{
		src = "https://github.com/rose-pine/neovim",
		name = "rose-pine",
	},
	{
		src = "https://github.com/doums/darcula",
		name = "darcula",
	},
	{
		src = "https://github.com/AlexvZyl/nordic.nvim",
		name = "nordic.nvim",
	},
	{
		src = "https://github.com/Shatur/neovim-ayu",
		name = "neovim-ayu",
	},
	{
		src = "https://github.com/projekt0n/github-nvim-theme",
		name = "github-theme",
	},
	{
		src = "https://github.com/arturgoms/moonbow.nvim",
		name = "moonbow.nvim",
	},
	{
		src = "https://github.com/sainnhe/gruvbox-material",
		name = "gruvbox-material",
	},
	{
		src = "https://github.com/savq/melange-nvim",
		name = "melange-nvim",
	},
	{
		src = "https://github.com/BoHomola/vsassist.nvim",
		name = "vsassit",
	},
	{
		src = "https://github.com/Tsuzat/NeoSolarized.nvim",
		name = "neo_solarized",
	},
	{
		src = "https://github.com/rktjmp/lush.nvim",
		name = "lush",
	},
	{
		src = "https://github.com/zenbones-theme/zenbones.nvim",
		name = "zenbones",
	},
	{
		src = "https://github.com/WTFox/luna.nvim",
		name = "luna",
	},
	{
		src = "https://github.com/Aejkatappaja/cendre",
		name = "cendre",
	},
	{
		src = "https://github.com/tanmaymanojgandhi/circadia",
		name = "circadia",
	},
})

require("catppuccin").setup({
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
		nvimtree = true,
	},
})

require("kanagawa").setup({
	transparent = true,
	overrides = function(colors)
		return {
			["@markup.link.url.markdown_inline"] = { link = "Special" },
			["@markup.link.label.markdown_inline"] = { link = "WarningMsg" },
			["@markup.italic.markdown_inline"] = { link = "Exception" },
			["@markup.raw.markdown_inline"] = { link = "String" },
			["@markup.list.markdown"] = { link = "Function" },
			["@markup.quote.markdown"] = { link = "Error" },
			["@markup.list.checked.markdown"] = { link = "WarningMsg" },
		}
	end,
})

vim.g.everforest_background = "hard"
vim.g.everforest_enable_italic = 1

vim.g.gruvbox_background = "hard"

vim.g.gruvbox_material_foreground = "mix"
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_enable_italic = true

require("rose-pine").setup({
	disable_background = true,
	styles = {
		italic = false,
	},
})

require("luna").setup({
	transparent = false,
	accent = 1.0, -- 0-1, blends syntax accents toward grey_light; 1 = full color
	plugins = {
		all = true, -- enable every plugin integration unconditionally
		auto = true, -- when plugins.all is false, autodetect via lazy.nvim
	},
	on_colors = function(colors) end,
	on_highlights = function(highlights, colors) end,
})

vim.cmd.colorscheme("melange")
