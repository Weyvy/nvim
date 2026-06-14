vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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
		src = "https://github.com/nvim-tree/nvim-tree.lua",
		name = "nvim-tree",
	},
})

require("nvim-tree").setup({
	sort = {
		sorter = "case_sensitive",
	},

	view = {
		width = 45,
		side = "right",
	},

	renderer = {
		group_empty = true,
		highlight_git = "icon",
	},

	filters = {
		dotfiles = true,
	},
})

vim.keymap.set("n", "<leader>ee", vim.cmd.NvimTreeToggle, {
	desc = "Toggle file explorer",
})

vim.keymap.set("n", "<leader>ef", vim.cmd.NvimTreeFindFile, {
	desc = "Find current file in explorer",
})

vim.keymap.set("n", "<leader>er", vim.cmd.NvimTreeRefresh, {
	desc = "Refresh file explorer",
})

vim.keymap.set("n", "<leader>et", vim.cmd.NvimTreeFocus, {
	desc = "Focus file explorer",
})

vim.keymap.set("n", "<leader>ec", vim.cmd.NvimTreeCollapse, {
	desc = "Collapse file explorer recursively",
})

vim.keymap.set("n", "<leader>ei", function()
	vim.cmd("NvimTreeResize +10")
end, {
	desc = "Increase file explorer width",
})

vim.keymap.set("n", "<leader>ed", function()
	vim.cmd("NvimTreeResize -10")
end, {
	desc = "Decrease file explorer width",
})
