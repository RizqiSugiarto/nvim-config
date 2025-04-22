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

	-- Install the DAP adapter via Mason
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = { "js-debug-adapter" },
				automatic_setup = true,
			})
		end,
	},

	-- Language-specific DAP config for JS/TS
	{
		"mxsdev/nvim-dap-vscode-js",
		dependencies = {
			"mfussenegger/nvim-dap",
			"microsoft/vscode-js-debug",
		},
		config = function()
			local dap = require("dap")
			require("dap.ext.vscode").load_launchjs(nil, {})

			-- Setup the JavaScript/TypeScript DAP adapter
			dap.adapters["pwa-node"] = {
				type = "server",
				host = "127.0.0.1",
				port = 8123,
				executable = {
					command = "js-debug-adapter", -- Ensure js-debug-adapter is available in your PATH
				},
			}

			-- Configure JavaScript/TypeScript launch configurations
			for _, language in ipairs({ "typescript", "javascript" }) do
				dap.configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
						runtimeExecutable = "node",
					},
				}
			end
		end,
	},
}
