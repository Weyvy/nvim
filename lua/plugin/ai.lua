vim.g.copilot_no_maps = true

vim.pack.add({
	{
		src = "https://github.com/github/copilot.vim",
		name = "copilot.vim",
	},
}, {
	load = false,
})

local copilot_loaded = false

local function load_copilot()
	if copilot_loaded then
		return
	end

	copilot_loaded = true

	vim.cmd.packadd("copilot.vim")

	vim.api.nvim_create_augroup("github_copilot", {
		clear = true,
	})

	vim.api.nvim_create_autocmd({ "FileType", "BufUnload" }, {
		group = "github_copilot",
		callback = function(args)
			vim.fn["copilot#On" .. args.event]()
		end,
	})

	vim.fn["copilot#OnFileType"]()
end

vim.api.nvim_create_autocmd("BufWinEnter", {
	once = true,
	callback = load_copilot,
})