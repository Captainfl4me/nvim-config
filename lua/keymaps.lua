vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])
vim.keymap.set('i', '<C-c>', '<esc>')

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- replace currently selected text with default register without yanking it
vim.keymap.set('v', '<leader>p', '"_dP', { desc = "Replace without yank" })

-- Code
vim.keymap.set({ "v", "n" }, "<leader>ca", require("actions-preview").code_actions)
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Go to Declaration" })
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, desc = "Hover info" })
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Signature help" })
		vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder,
			{ buffer = ev.buf, desc = "Add workspace folder" })
		vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
			{ buffer = ev.buf, desc = "Remove workspace folder" })
		vim.keymap.set('n', '<leader>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, { buffer = ev.buf, desc = "List workspace folder" })
		vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition,
			{ buffer = ev.buf, desc = "Jump to type definition" })
		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename" })
		vim.keymap.set('n', '<leader>cf', function()
			vim.lsp.buf.format { async = true }
		end, { buffer = ev.buf, desc = "Format code with LSP" })
	end,
})
