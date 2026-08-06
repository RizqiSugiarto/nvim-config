return {
	"nickjvandyke/opencode.nvim",
	version = "*", -- Latest stable release
	config = function()
		---@type opencode.Opts
		vim.g.opencode_opts = {
			-- Your configuration, if any
		}

		local opencode_cmd = "opencode"

		local snacks_terminal_opts = {
			win = {
				position = "right",
				width = 0.45,
			},
		}

		vim.keymap.set({ "n", "t" }, "<leader>op", function()
			require("snacks.terminal").toggle(opencode_cmd, snacks_terminal_opts)
		end, { desc = "Toggle OpenCode" })

		vim.keymap.set({ "n", "x" }, "<leader>oca", function()
			require("opencode").ask("@this: ")
		end, { desc = "OpenCode: Ask…" })

		vim.keymap.set({ "n", "x" }, "<leader>ocs", function()
			require("opencode").select()
		end, { desc = "OpenCode: Select prompt…" })

		vim.keymap.set({ "n", "x" }, "<leader>oco", function()
			return require("opencode").operator("@this ")
		end, { desc = "OpenCode: Append range", expr = true })

		vim.keymap.set({ "n" }, "<leader>ocl", function()
			return require("opencode").operator("@this ") .. "_"
		end, { desc = "OpenCode: Append line", expr = true })

		vim.keymap.set({ "n" }, "<leader>ocu", function()
			require("opencode").command("session.half.page.up")
		end, { desc = "OpenCode: Scroll up" })

		vim.keymap.set({ "n" }, "<leader>ocd", function()
			require("opencode").command("session.half.page.down")
		end, { desc = "OpenCode: Scroll down" })
	end,
}
