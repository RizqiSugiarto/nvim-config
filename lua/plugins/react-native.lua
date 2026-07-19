-- React Native + Tailwind support

local function rn_terminal(cmd_str)
	vim.cmd("botright split | terminal " .. cmd_str)
	vim.cmd("startinsert")
end

return {
	-- ──────────────────────────────────────────────────────────────────────────
	-- Lightweight Tailwind: piggybacks on existing ts_ls — no extra LSP process
	-- ──────────────────────────────────────────────────────────────────────────
	{
		"luckasRanarison/tailwind-tools.nvim",
		name = "tailwind-tools",
		build = ":UpdateRemotePlugins",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			server = {
				enabled = false, -- don't spawn tailwindcss-language-server; piggyback on ts_ls instead
			},
			document_color = {
				enabled = true,
				kind = "inline",
				inline_symbol = "󰝤 ",
				debounce = 200,
			},
			conceal = {
				enabled = false,
			},
			cmp = {
				highlight = "foreground",
			},
			telescope = {
				utilities = {
					callback = function(name, class)
						vim.api.nvim_put({ class }, "c", false, true)
					end,
				},
			},
		},
		config = function(_, opts)
			require("tailwind-tools").setup(opts)

			vim.keymap.set("n", "<leader>tc", "<cmd>TailwindConcealToggle<cr>", { desc = "[T]ailwind [C]onceal toggle" })
			vim.keymap.set("n", "<leader>ts", "<cmd>TailwindColorToggle<cr>", { desc = "[T]ailwind color [S]watch toggle" })
			vim.keymap.set("n", "<leader>tS", "<cmd>TailwindSort<cr>", { desc = "[T]ailwind [S]ort classes" })
			vim.keymap.set("v", "<leader>tS", "<cmd>TailwindSort<cr>", { desc = "[T]ailwind [S]ort classes (selection)" })
		end,
	},

	-- ──────────────────────────────────────────────────────────────────────────
	-- React Native terminal helpers (zero plugin weight)
	-- ──────────────────────────────────────────────────────────────────────────
	{
		"nvim-lua/plenary.nvim", -- already a dep elsewhere; just piggyback for config hook
		lazy = false,
		config = function()
			-- Start Metro bundler
			vim.api.nvim_create_user_command("RNStart", function()
				rn_terminal("npx react-native start")
			end, { desc = "Start React Native Metro bundler" })

			-- Run on Android (real device / emulator)
			vim.api.nvim_create_user_command("RNAndroid", function()
				rn_terminal("npx react-native run-android")
			end, { desc = "Run React Native on Android" })

			-- Run on iOS
			vim.api.nvim_create_user_command("RNIos", function()
				rn_terminal("npx react-native run-ios")
			end, { desc = "Run React Native on iOS" })

			vim.keymap.set("n", "<leader>rm", "<cmd>RNStart<cr>",   { desc = "[R]N [M]etro bundler" })
			vim.keymap.set("n", "<leader>ra", "<cmd>RNAndroid<cr>", { desc = "[R]N run [A]ndroid" })
			vim.keymap.set("n", "<leader>ri", "<cmd>RNIos<cr>",     { desc = "[R]N run [I]os" })
		end,
	},
}
