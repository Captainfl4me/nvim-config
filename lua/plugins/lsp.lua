local M = {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"nvim-lua/lsp-status.nvim",
			{
				"tamago324/nlsp-settings.nvim",
				opts = {
					config_home = vim.fn.stdpath('config') .. '/nlsp-settings',
					local_settings_dir = ".nvim/nlsp-settings",
					local_settings_root_markers_fallback = { '.git' },
					append_default_schemas = true,
					loader = 'json'
				}
			},
			"Hoffs/omnisharp-extended-lsp.nvim",
		},
	},
	{
		"williamboman/mason.nvim",
		opts = {},
	},
	{
		"folke/neodev.nvim",
		opts = {},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = 'UIEnter',
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
			"folke/neodev.nvim",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"clangd",
					"rust_analyzer",
					"lua_ls",
					"omnisharp",
					"pyright",
					"ltex",
				},
			})

			require("mason-lspconfig").setup_handlers {
				function (server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup {}
				end,

				["rust_analyzer"] = function ()
					require("lspconfig").rust_analyzer.setup {
						settings = {
							['rust-analyzer'] = {},
						},
					}
				end,
				["omnisharp"] = function()
					require("lspconfig").omnisharp.setup {
						handlers = {
							["textDocument/definition"] = require('omnisharp_extended').handler,
						},
						cmd = { "omnisharp", '--languageserver', '--hostPID', tostring(vim.fn.getpid()) },
					}
				end,
			}

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
					vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action,
						{ buffer = ev.buf, desc = "Show code action" })
					vim.keymap.set('n', '<leader>f', function()
						vim.lsp.buf.format { async = true }
					end, { buffer = ev.buf, desc = "Go to Declaration" })
				end,
			})
		end
	},
}

return M
