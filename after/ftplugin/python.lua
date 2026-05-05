vim.bo.syntax = "off"
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
pcall(vim.treesitter.start)
