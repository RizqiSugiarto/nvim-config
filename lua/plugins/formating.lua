return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"jayp0521/mason-null-ls.nvim", -- ensure dependencies are installed
	},
	config = function()
		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting -- to setup formatters
		local diagnostics = null_ls.builtins.diagnostics -- to setup linters

		-- Formatters & linters for mason to install
		require("mason-null-ls").setup({
			ensure_installed = {
				"golangci_lint", -- golang linter
				"eslint_d", -- ts/js linter
				"prettier", -- ts/js formatter
				"black", -- python formatter
				"stylua", -- lua formatter
				"shfmt", -- Shell formatter
				"checkmake", -- linter for Makefiles
				"gofmt", -- Go formatter (or golines)
			},
			automatic_installation = true,
		})

		local sources = {
			diagnostics.checkmake,
			diagnostics.golangci_lint,
			formatting.prettier.with({
				filetypes = { "html", "json", "yaml", "markdown", "typescript", "javascript", "jsx", "tsx", "vue" },
			}),
			formatting.stylua,
			formatting.shfmt.with({ args = { "-i", "4" } }),
			formatting.black,
			formatting.gofmt,
			formatting.clang_format.with({
				extra_args = { "--style=Google" },
			}),
		}

		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		null_ls.setup({
			-- debug = true, -- Enable debug mode. Inspect logs with :NullLsLog.
			sources = sources,
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end,
		})
	end,
}
