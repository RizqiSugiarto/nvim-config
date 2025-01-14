return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			{ "fredrikaverpil/neotest-golang", version = "*" },
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-golang")({
						go_test_args = {
							"-v",
							"-race",
							"-count=1",
							"-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
						},
					}),
				},
			})
		end,
		keys = {
			{
				"<leader>tn",
				function()
					require("neotest").run.run()
				end,
				desc = "start nearest test",
			},
			{
				"<leader>tf",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "test current file",
			},
			{
				"<leader>tw",
				function()
					require("neotest").watch.toggle(vim.fn.expand("%"))
				end,
				desc = "test watching current file",
			},
			{
				"<leader>tt",
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = "toggle output panel",
			},
			{
				"<leader>ts",
				function()
					require("neotest").run.stop()
				end,
				desc = "Stop nearest test",
			},
		},
	},
}
