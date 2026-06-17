return {
	"mceazy2700/antigravity-cli.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("antigravity-cli").setup({
			command = "agy",

			terminal = {
				provider = "native",
				position = "right",
				size = 80,
			},
		})
	end,
}
