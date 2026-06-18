-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- For conciseness
local opts = { noremap = true, silent = true }

-- save file
vim.keymap.set("n", "<C-s>", "<cmd> w <CR>", opts)

-- save file without auto-formatting
vim.keymap.set("n", "<leader>sn", "<cmd>noautocmd w <CR>", opts)

-- quit file
vim.keymap.set("n", "<C-q>", "<cmd> q <CR>", opts)

-- delete single character without copying into register
vim.keymap.set("n", "x", '"_x', opts)

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Find and center
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- Resize with arrows
vim.keymap.set("n", "<Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<Right>", ":vertical resize +2<CR>", opts)

-- Buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", opts)
vim.keymap.set("n", "<leader>x", ":bdelete!<CR>", opts)            -- close buffer
vim.keymap.set("n", "<leader>xa", ":bufdo bd | tabonly<CR>", opts) -- close all buffer
vim.keymap.set("n", "<leader>b", "<cmd> enew <CR>", opts)          -- new buffer

-- Window management
vim.keymap.set("n", "<leader>v", "<C-w>v", opts)      -- split window vertically
vim.keymap.set("n", "<leader>h", "<C-w>s", opts)      -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", opts)     -- make split windows equal width & height
vim.keymap.set("n", "<leader>xs", ":close<CR>", opts) -- close current split window

-- Navigate between splits
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", opts)
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", opts)
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", opts)
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", opts)

-- Tabs
vim.keymap.set("n", "<leader>to", ":tabnew<CR>", opts)   -- open new tab
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", opts) -- close current tab
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", opts)     --  go to next tab
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", opts)     --  go to previous tab

-- Toggle line wrapping
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", opts)

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', opts)

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Map delete commands to discard content to the black hole register
vim.keymap.set("n", "d", '"_d', { noremap = true }) -- Normal mode delete
vim.keymap.set("v", "d", '"_d', { noremap = true }) -- Visual mode delete

-- Set up DAP keymaps
vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
vim.keymap.set("n", "<F5>", ":lua require('dap').continue()<CR>", { silent = true })
vim.keymap.set("n", "<F9>", ":lua require('dap').toggle_breakpoint()<CR>", { silent = true })
vim.keymap.set("n", "<leader>o", ":lua require('dap').step_over()<CR>", { silent = true })
vim.keymap.set("n", "<leader>i", ":lua require('dap').step_into()<CR>", { silent = true })
vim.keymap.set("n", "<leader>ou", ":lua require('dap').step_out()<CR>", { silent = true })
vim.keymap.set("n", "<leader>oi", ":lua require('dap').disconnect()<CR>", { silent = true })
vim.keymap.set("n", "<leader>or", ":lua require('dap').restart()<CR>", { silent = true })

vim.keymap.set("n", "<leader>du", ":lua require('dapui').open()<CR>", { silent = true })
vim.keymap.set("n", "<leader>dc", ":lua require('dapui').close()<CR>", { silent = true })

-- Antigravity integration

vim.keymap.set("n", "<leader>ac", "<cmd>Antigravity<CR>", {
	desc = "Antigravity: Toggle Terminal",
	silent = true,
})

vim.keymap.set("n", "<leader>ar", "<cmd>AntigravityResume<CR>", {
	desc = "Antigravity: Resume Session",
	silent = true,
})

vim.keymap.set("n", "<leader>am", "<cmd>AntigravitySelectModel<CR>", {
	desc = "Antigravity: Select Model",
	silent = true,
})

vim.keymap.set({ "n", "v" }, "<leader>aa", "<cmd>AntigravityAsk<CR>", {
	desc = "Antigravity: Ask",
	silent = true,
})

vim.keymap.set("n", "<leader>ab", function()
	require("antigravity-cli.integrations").add_to_context(vim.api.nvim_buf_get_name(0))
end, {
	desc = "Antigravity: Add Buffer Context",
	silent = true,
})

vim.keymap.set("n", "<leader>ay", "<cmd>AntigravityDiffAccept<CR>", {
	desc = "Antigravity: Accept Diff",
	silent = true,
})

vim.keymap.set("n", "<leader>an", "<cmd>AntigravityDiffDeny<CR>", {
	desc = "Antigravity: Reject Diff",
	silent = true,
})

-- antigravity terminal movement
vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]])
vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]])
vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]])
vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]])

-- code reference
vim.keymap.set("v", "<leader>cl", function()
	local start_line = vim.fn.line("v")
	local end_line = vim.fn.line(".")

	if start_line > end_line then
		start_line, end_line = end_line, start_line
	end

	local path = vim.fn.expand("%")
	local content = string.format("%s#L%d-L%d", path, start_line, end_line)

	vim.fn.setreg("+", content)

	-- Leave visual mode
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)

	print("Copied code reference")
end, {
	desc = "Copy Code Reference",
	silent = true,
})
