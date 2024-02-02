local M = {
	{
		"neovim/nvim-lspconfig",
		dependencies = { "nvim-lua/lsp-status.nvim" },
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
		lazy = false,
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
		end
	},
}

return M
