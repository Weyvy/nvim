local pack_build = require("plugin.pack_build")

pack_build.setup()

pack_build.register("telescope-fzf-native.nvim", function(data, run_build)
	if vim.fn.executable("make") == 1 then
		run_build("telescope-fzf-native.nvim", { "make" }, data.path)
		return
	end

	if vim.fn.executable("cmake") == 1 then
		run_build("telescope-fzf-native.nvim", {
			"sh",
			"-c",
			"cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install",
		}, data.path)
		return
	end

	vim.notify("Neither make nor cmake found. telescope-fzf-native.nvim was not built.", vim.log.levels.WARN)
end)

local telescope_plugins = {
	{
		src = "https://github.com/nvim-lua/plenary.nvim",
		name = "plenary.nvim",
	},
	{
		src = "https://github.com/nvim-telescope/telescope.nvim",
		name = "telescope.nvim",
	},
	{
		src = "https://github.com/nvim-telescope/telescope-ui-select.nvim",
		name = "telescope-ui-select.nvim",
	},
}

if vim.g.have_nerd_font then
	table.insert(telescope_plugins, {
		src = "https://github.com/nvim-tree/nvim-web-devicons",
		name = "nvim-web-devicons",
	})
end

if vim.fn.executable("make") == 1 or vim.fn.executable("cmake") == 1 then
	table.insert(telescope_plugins, {
		src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
		name = "telescope-fzf-native.nvim",
	})
end

vim.pack.add(telescope_plugins)

local telescope = require("telescope")
local builtin = require("telescope.builtin")
local themes = require("telescope.themes")

telescope.setup({
	defaults = {
		wrap_results = true,
	},

	pickers = {
		colorscheme = {
			enable_preview = true,
		},
	},

	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},

		["ui-select"] = {
			themes.get_dropdown(),
		},
	},
})

pcall(telescope.load_extension, "fzf")
pcall(telescope.load_extension, "ui-select")

vim.keymap.set("n", "<leader>sh", builtin.help_tags, {
	desc = "[S]earch [H]elp",
})

vim.keymap.set("n", "<leader>sk", builtin.keymaps, {
	desc = "[S]earch [K]eymaps",
})

vim.keymap.set("n", "<leader>ff", builtin.find_files, {
	desc = "[S]earch [F]iles",
})

vim.keymap.set("n", "<leader>s.", builtin.builtin, {
	desc = "[S]earch [S]elect Telescope",
})

vim.keymap.set({ "n", "v" }, "<leader>sw", builtin.grep_string, {
	desc = "[S]earch current [W]ord",
})

vim.keymap.set("n", "<leader>sg", builtin.live_grep, {
	desc = "[S]earch by [G]rep",
})

vim.keymap.set("n", "<leader>sd", builtin.diagnostics, {
	desc = "[S]earch [D]iagnostics",
})

vim.keymap.set("n", "<leader>sr", builtin.resume, {
	desc = "[S]earch [R]esume",
})

vim.keymap.set("n", "<leader>ss", function()
	builtin.oldfiles({
		cwd_only = true,
	})
end, {
	desc = "[S]earch Recent Files in Current Directory",
})

vim.keymap.set("n", "<leader>sc", builtin.commands, {
	desc = "[S]earch [C]ommands",
})

vim.keymap.set("n", "<leader><leader>", function()
	builtin.buffers({
		sort_mru = true,
		sort_lastused = true,
		ignore_current_buffer = true,
	})
end, {
	desc = "Find existing buffers",
})

vim.keymap.set("n", "<leader>/", function()
	builtin.current_buffer_fuzzy_find(themes.get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, {
	desc = "[/] Fuzzily search in current buffer",
})

vim.keymap.set("n", "<leader>s/", function()
	builtin.live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end, {
	desc = "[S]earch [/] in open files",
})

vim.keymap.set("n", "<leader>sn", function()
	builtin.find_files({
		cwd = vim.fn.stdpath("config"),
		prompt_title = "Neovim Config Files",
	})
end, {
	desc = "[S]earch [N]eovim files",
})

vim.keymap.set("n", "<leader>cs", "<cmd>Telescope colorscheme<CR>", {
	desc = "Live colorscheme preview",
})

vim.keymap.set("n", "<leader>Q", function()
	builtin.diagnostics()
end, {
	desc = "Diagnostics workspace",
})

vim.keymap.set("n", "<leader>q", function()
	builtin.diagnostics({
		bufnr = 0,
	})
end, {
	desc = "Diagnostics buffer",
})

vim.keymap.set("n", "<leader>sj", builtin.jumplist, {
	desc = "[S]earch [J]ump List",
})

vim.keymap.set("n", "<leader>d", function()
	local current_buf = vim.api.nvim_get_current_buf()
	local current_file = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(current_buf), ":p")

	local qf_items = vim.fn.getqflist()
	local buffer_items = {}

	for _, item in ipairs(qf_items) do
		local same_buffer = false

		if item.bufnr and item.bufnr ~= 0 then
			local ok, item_file = pcall(vim.api.nvim_buf_get_name, item.bufnr)
			if ok then
				item_file = vim.fn.fnamemodify(item_file, ":p")
				same_buffer = item_file == current_file
			end
		end

		if not same_buffer and item.filename then
			local item_file = vim.fn.fnamemodify(item.filename, ":p")
			same_buffer = item_file == current_file
		end

		if same_buffer then
			table.insert(buffer_items, item)
		end
	end

	if vim.tbl_isempty(buffer_items) then
		vim.notify("No quickfix items for current buffer", vim.log.levels.INFO)
		return
	end

	vim.fn.setloclist(0, {}, "r", {
		title = "Buffer Quickfix",
		items = buffer_items,
	})

	builtin.loclist({
		prompt_title = "Buffer Quickfix",
	})
end, {
	desc = "Quickfix buffer",
})

vim.keymap.set("n", "<leader>D", function()
	builtin.quickfix({
		prompt_title = "Project Quickfix",
	})
end, {
	desc = "Quickfix project",
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("telescope-lsp-attach", { clear = true }),
	callback = function(event)
		local buf = event.buf

		vim.keymap.set("n", "grr", builtin.lsp_references, {
			buffer = buf,
			desc = "[G]oto [R]eferences",
		})

		vim.keymap.set("n", "gri", builtin.lsp_implementations, {
			buffer = buf,
			desc = "[G]oto [I]mplementation",
		})

		vim.keymap.set("n", "grd", builtin.lsp_definitions, {
			buffer = buf,
			desc = "[G]oto [D]efinition",
		})

		vim.keymap.set("n", "gO", builtin.lsp_document_symbols, {
			buffer = buf,
			desc = "Open document symbols",
		})

		vim.keymap.set("n", "gW", builtin.lsp_dynamic_workspace_symbols, {
			buffer = buf,
			desc = "Open workspace symbols",
		})

		vim.keymap.set("n", "grt", builtin.lsp_type_definitions, {
			buffer = buf,
			desc = "[G]oto [T]ype definition",
		})
	end,
})

vim.pack.add({
	{
		src = "https://codeberg.org/andyg/leap.nvim",
		name = "leap",
	},
})

local leap = require("leap")

leap.setup({})

vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)", {
	desc = "Leap",
})

vim.keymap.set("n", "S", "<Plug>(leap-from-window)", {
	desc = "Leap from window",
})

leap.opts.equivalence_classes = {
	" \t\r\n",
	"([{",
	")]}",
	"'\"`",
}

require("leap.user").set_repeat_keys("<enter>", "<backspace>")

leap.opts.preview_filter = function(ch0, ch1, ch2)
	return not (ch1:match("%s") or ch0:match("%a") and ch1:match("%a") and ch2:match("%a"))
end

vim.o.foldcolumn = "0"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
