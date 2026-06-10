-- debug.lua
-- Debugging with nvim-dap for Go, C, C++, Rust, and Python
-- No Mason

vim.pack.add({
	{
		src = "https://github.com/mfussenegger/nvim-dap",
		name = "nvim-dap",
	},
	{
		src = "https://github.com/rcarriga/nvim-dap-ui",
		name = "nvim-dap-ui",
	},
	{
		src = "https://github.com/nvim-neotest/nvim-nio",
		name = "nvim-nio",
	},
	{
		src = "https://github.com/leoluz/nvim-dap-go",
		name = "nvim-dap-go",
	},
	{
		src = "https://github.com/mfussenegger/nvim-dap-python",
		name = "nvim-dap-python",
	},
})

local dap = require("dap")
local dapui = require("dapui")

-- [[ Keymaps ]]

vim.keymap.set("n", "<F5>", function()
	dap.continue()
end, { desc = "Debug: Start/Continue" })

vim.keymap.set("n", "<F1>", function()
	dap.step_into()
end, { desc = "Debug: Step Into" })

vim.keymap.set("n", "<F2>", function()
	dap.step_over()
end, { desc = "Debug: Step Over" })

vim.keymap.set("n", "<F3>", function()
	dap.step_out()
end, { desc = "Debug: Step Out" })

vim.keymap.set("n", "<leader>b", function()
	dap.toggle_breakpoint()
end, { desc = "Debug: Toggle Breakpoint" })

vim.keymap.set("n", "<leader>B", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Debug: Set Conditional Breakpoint" })

vim.keymap.set("n", "<F7>", function()
	dapui.toggle()
end, { desc = "Debug: Toggle DAP UI" })

vim.keymap.set("n", "<leader>dr", function()
	dap.repl.open()
end, { desc = "Debug: Open REPL" })

vim.keymap.set("n", "<leader>dl", function()
	dap.run_last()
end, { desc = "Debug: Run Last" })

vim.keymap.set("n", "<leader>dt", function()
	dap.terminate()
end, { desc = "Debug: Terminate" })

-- [[ DAP UI ]]

dapui.setup({
	icons = {
		expanded = "▾",
		collapsed = "▸",
		current_frame = "*",
	},

	controls = {
		icons = {
			pause = "⏸",
			play = "▶",
			step_into = "⏎",
			step_over = "⏭",
			step_out = "⏮",
			step_back = "b",
			run_last = "▶▶",
			terminate = "⏹",
			disconnect = "⏏",
		},
	},
})

dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

-- [[ Signs ]]

vim.api.nvim_set_hl(0, "DapBreak", { fg = "#e51400" })
vim.api.nvim_set_hl(0, "DapStop", { fg = "#ffcc00" })

local breakpoint_icons = {
	Breakpoint = "●",
	BreakpointCondition = "⊜",
	BreakpointRejected = "⊘",
	LogPoint = "◆",
	Stopped = "⭔",
}

for type, icon in pairs(breakpoint_icons) do
	local tp = "Dap" .. type
	local hl = type == "Stopped" and "DapStop" or "DapBreak"

	vim.fn.sign_define(tp, {
		text = icon,
		texthl = hl,
		numhl = hl,
	})
end

-- [[ Go ]]
-- Requires: dlv

require("dap-go").setup({
	delve = {
		path = "dlv",
		detached = vim.fn.has("win32") == 0,
	},
})

-- [[ Python ]]
-- Requires:
-- python3 -m pip install debugpy

require("dap-python").setup("python3")

-- [[ C / C++ / Rust ]]
-- Requires: codelldb in PATH

dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = "codelldb",
		args = { "--port", "${port}" },
	},
}

dap.configurations.cpp = {
	{
		name = "Launch executable",
		type = "codelldb",
		request = "launch",

		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,

		cwd = "${workspaceFolder}",
		stopOnEntry = false,

		args = function()
			local args_string = vim.fn.input("Arguments: ")
			return vim.split(args_string, " ", { trimempty = true })
		end,
	},

	{
		name = "Attach to process",
		type = "codelldb",
		request = "attach",
		pid = require("dap.utils").pick_process,
		cwd = "${workspaceFolder}",
	},
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp