return {
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
			require("dapui").setup()
		end,
	},

	{
		"leoluz/nvim-dap-go",
		config = function()
			local dap = require("dap")

			-- Load launch configurations from VSCode (optional)
			require("dap.ext.vscode").load_launchjs(nil, {})

			-- Setup nvim-dap-go
			require("dap-go").setup()

			-- Configure Go adapter for debugging
			dap.adapters.go = function(callback, config)
				vim.defer_fn(function()
					-- Launch Delve for local debugging
					callback({
						type = "server",
						host = "127.0.0.1",
						port = 38697, -- The port Delve will listen on
						executable = {
							command = "dlv", -- Start Delve
							args = {
								"dap",
								"-l",
								"127.0.0.1:38697", -- Listen on this port
								"--log",
								"--log-output=dap",
							},
							detached = true, -- Detach so it doesn't block the process
						},
					})
				end, 100) -- Delay to ensure the adapter is initialized properly
			end

			-- Go debugging configurations
			dap.configurations.go = {
				{
					type = "go",
					name = "Debug File",
					request = "launch",
					program = "${file}", -- Debug the current file
				},
				{
					type = "go",
					name = "Debug Package",
					request = "launch",
					program = "${workspaceFolder}", -- Debug the entire workspace
				},
			}
		end,
	},
}
