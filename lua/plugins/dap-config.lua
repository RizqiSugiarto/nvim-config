return {
	-- DAP UI
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dapui.setup()

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},

	-- Go DAP
	{
		"leoluz/nvim-dap-go",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			local dap = require("dap")
			require("dap-go").setup()
			require("dap.ext.vscode").load_launchjs(nil, {})

			dap.adapters.go = function(callback, _)
				vim.defer_fn(function()
					callback({
						type = "server",
						host = "127.0.0.1",
						port = 38697,
						executable = {
							command = "dlv",
							args = {
								"dap",
								"-l",
								"127.0.0.1:38697",
								"--log",
								"--log-output=dap",
							},
							detached = true,
						},
					})
				end, 100)
			end

			dap.configurations.go = {
				{
					type = "go",
					name = "Debug File",
					request = "launch",
					program = "${file}",
				},
				{
					type = "go",
					name = "Debug Package",
					request = "launch",
					program = "${workspaceFolder}",
				},
			}
		end,
	},
	-- Js / Ts DAP (manual installation) - https://github.com/mxsdev/nvim-dap-vscode-js
	{
		"mxsdev/nvim-dap-vscode-js",
		dependencies = {
			"mfussenegger/nvim-dap",
			"microsoft/vscode-js-debug", -- This will be automatically installed
		},
		config = function()
			local debug_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"
			require("dap-vscode-js").setup({
				-- node_path = "node", -- Path to node if you want to override
				debugger_path = debug_path,
				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge" }, -- Add adapters you need
			})

			require("dap").adapters["pwa-node"] = {
				type = "server",
				host = "127.0.0.1",
				port = "${port}",
				executable = {
					command = "node",
					args = {
						debug_path .. "/out/src/vsDebugServer.js",
						"${port}",
					},
				},
			}

			require("dap.ext.vscode").load_launchjs(nil, {
				["pwa-node"] = { "javascript", "typescript" },
				["node"] = { "javascript", "typescript" },
			})
		end,
	},
}
