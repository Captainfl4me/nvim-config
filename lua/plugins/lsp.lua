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
		opts = {
			ensure_installed = {
				"clangd",
				"rust_analyzer",
				"lua_ls",
			}
		},
		config = function()
			local lspconfig = require('lspconfig')
			lspconfig.lua_ls.setup {}
			lspconfig.clangd.setup {}
			lspconfig.rust_analyzer.setup {
			  settings = {
				['rust-analyzer'] = {},
			  },
			}

			vim.api.nvim_create_autocmd('LspAttach', {
			  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
			  callback = function(ev)
				-- Enable completion triggered by <c-x><c-o>
				vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf }
				vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
				vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
				vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
				vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
				vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
				vim.keymap.set('n', '<leader>wl', function()
				  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, opts)
				vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
				vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
				vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
				vim.keymap.set('n', '<leader>f', function()
				  vim.lsp.buf.format { async = true }
				end, opts)
			  end,
			})
		end
	},
}

return M
