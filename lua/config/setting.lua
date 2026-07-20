vim.loader.enable()

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true
vim.opt.termguicolors = true

vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.relativenumber = true

vim.o.showmode = false

vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)
vim.o.mouse = "a"

vim.o.breakindent = true

vim.o.undofile = true

vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.inccommand = "split"

vim.o.cursorline = true

vim.o.scrolloff = 10

vim.o.list = true
vim.opt.listchars = {
	tab = "» ",
	trail = "·",
	nbsp = "␣",
}

vim.o.confirm = true

vim.diagnostic.config({
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = { min = vim.diagnostic.severity.WARN } },

	-- Can switch between these as you prefer
	virtual_text = true, -- Text shows up at the end of the line
	virtual_lines = false, -- Text shows up underneath the line, with virtual lines

	-- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
	jump = {
		on_jump = function(_, bufnr)
			vim.diagnostic.open_float({
				bufnr = bufnr,
				scope = "cursor",
				focus = false,
			})
		end,
	},
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.opt.colorcolumn = "80"

-- tab and indent options
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.autoindent = true

vim.diagnostic.config({
	underline = true,
})

vim.o.winborder = "rounded"

-- Rounded border for completion popup menus
vim.o.pumborder = "rounded"

-- Nicer popup behavior
vim.o.completeopt = "menu,menuone,noselect"
vim.o.pumheight = 12
vim.o.winblend = 0
vim.o.pumblend = 5

-- Native command-line completion fallback
vim.o.wildmenu = true
vim.o.wildmode = "longest:full,full"

vim.opt.wrap = false
vim.opt.linebreak = true

-- Spell
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }
vim.opt.spelloptions = "camel"
