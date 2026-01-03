-- ui
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.showmode = false

-- font options
vim.g.have_nerd_font = true
vim.opt.termguicolors = true

-- search options
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- tab and indent options
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.autoindent = true

-- left columns
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.signcolumn = "yes"

-- line
vim.opt.wrap = false

-- undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
vim.opt.undofile = true

-- update
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.list = true
vim.opt.inccommand = "split"
vim.opt.cursorline = true

-- clipboard
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.mouse = ""
vim.opt.splitbelow = true
vim.opt.splitright = true

-- folding
vim.o.foldcolumn = '0'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- misc
vim.opt.confirm = true

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.colorcolumn = "80"

vim.opt.autoread = true
