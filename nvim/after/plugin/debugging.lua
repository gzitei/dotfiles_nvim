require("dapui").setup()
require("dap-go").setup()

table.insert(vim._so_trails, "/?.dylib")
require("dap-python").setup("python")

require("mason").setup()
require("mason-nvim-dap").setup({
	automatic_installation = true,
	ensure_installed = { "python", "delve" },
})

local dap, dapui = require("dap"), require("dapui")

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	--dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

vim.keymap.set("n", "<Leader>dui", require("dapui").toggle)
vim.keymap.set("n", "<Leader>dt", ":DapToggleBreakpoint<CR>")
vim.keymap.set("n", "<Leader>dc", ":DapContinue<CR>")
vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>")
vim.keymap.set("n", "<Leader>do", ":DapStepOver<CR>")

require("dap-vscode-js").setup({
	node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
	-- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
	-- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
	adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost", "node", "chrome" }, -- which adapters to register in nvim-dap
	-- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
	-- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
	-- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

local js_based_languages = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }

if not dap.adapters["node"] then
	dap.adapters["node"] = function(cb, config)
		if config.type == "node" then
			config.type = "pwa-node"
		end
		local nativeAdapter = dap.adapters["pwa-node"]
		if type(nativeAdapter) == "function" then
			nativeAdapter(cb, config)
		else
			cb(nativeAdapter)
		end
	end
end

for _, language in ipairs(js_based_languages) do
	dap.configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Run Test Debugger",
			runtimeExecutable = "npm",
			runtimeArgs = { "run", "test:dev" },
			rootPath = vim.fn.getcwd(),
			cwd = vim.fn.getcwd(),
			skipFiles = { "<node_internals>/**/**", "node_modules/**/**" },
			console = "integratedTerminal",
			postDebugTask = "Keep UI Open",
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
			postDebugTask = "Keep UI Open",
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
			postDebugTask = "Keep UI Open",
		},
		{
			type = "pwa-chrome",
			request = "launch",
			name = 'Start Chrome with "localhost"',
			url = "http://localhost:3000",
			webRoot = "${workspaceFolder}",
			userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
			postDebugTask = "Keep UI Open",
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Jest Debug",
			runtimeArgs = { "--experimental-vm-modules" },
			program = "${workspaceFolder}/node_modules/jest/bin/jest.js",
			args = { "--runInBand" },
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
			disableOptimisticBPs = true,
			cwd = "${workspaceFolder}",
			env = {
				NODE_ENV = "test",
			},
			skipFiles = { "<node_internals>/**", "node_modules/**" },
			sourceMaps = true,
			postDebugTask = "Keep UI Open",
		},
	}
end

dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		pythonPath = function()
			return "/usr/bin/python3"
		end,
		postDebugTask = "Keep UI Open",
	},
}

dap.adapters.python = {
	type = "executable",
	command = "python",
	args = { "-m", "debugpy.adapter" },
}

dap.set_log_level("TRACE")

require("dap.ext.vscode").load_launchjs(nil, {
	["pwa-node"] = js_based_languages,
	["node"] = js_based_languages,
	["chrome"] = js_based_languages,
	["pwa-chrome"] = js_based_languages,
})

dap.configurations["dap-repl"] = {
	{
		type = "pwa-node",
		request = "launch",
		name = "Launch DAP REPL",
		program = "${file}",
		cwd = "${workspaceFolder}",
		console = "integratedTerminal",
		internalConsoleOptions = "neverOpen",
	},
}
