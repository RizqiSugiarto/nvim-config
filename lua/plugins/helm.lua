return {
	{
		-- Helm chart filetype detection + helm-ls extras (block highlight, % jump, conceal, indent hints)
		"qvalentin/helm-ls.nvim",
		ft = "helm",
		opts = {
			conceal_templates = { enabled = false },
		},
	},
}
