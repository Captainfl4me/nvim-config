function get_project_rustanalyzer_settings()
	local handle = io.open(vim.fn.resolve(vim.fn.getcwd() .. '/./.rust-analyzer.json'))
	if not handle then
		return {}
	end
	local out = handle:read("*a")
	handle:close()
	local config = vim.json.decode(out)
	if type(config) == "table" then
		return config
	end
	return {}
end

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
				automatic_installation = true,
			})

			require("mason-lspconfig").setup_handlers {
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup {}
				end,

				["rust_analyzer"] = function()
					require("lspconfig").rust_analyzer.setup {
						settings = {
							['rust-analyzer'] = vim.tbl_deep_extend(
								"force",
								{
									checkOnSave = {
										command = "clippy",
										allTargets = false,
									},
								},
								get_project_rustanalyzer_settings(),
								{
									-- No overridable
								}
							)
						},
					}
				end,
				["clangd"] = function()
					require("lspconfig").clangd.setup {
						cmd = {
							"clangd",
							"--fallback-style=webkit" -- Force 4 tabs indent
						}
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
		end
	},
}

return M
