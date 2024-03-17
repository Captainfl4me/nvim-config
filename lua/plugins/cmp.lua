local M = {
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			{
				"zbirenbaum/copilot-cmp",
				dependencies = {
					"zbirenbaum/copilot.lua",
					cmd = "Copilot",
					event = "InsertEnter",
					opts = {
						suggestion = { enabled = false },
						panel = { enabled = false },
					},
				},
				opts = {},
			},
			"windwp/nvim-autopairs",

		},
		event = "InsertEnter",
		opts = function()
			-- nvim-cmp setup
			local cmp = require 'cmp'
			local cmp_autopairs = require('nvim-autopairs.completion.cmp')
			cmp.event:on(
				'confirm_done',
				cmp_autopairs.on_confirm_done()
			)
			return {
				snippet = { },
				mapping = cmp.mapping.preset.insert({
					['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
					['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
					-- C-b (back) C-f (forward) for snippet placeholder navigation.
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm {
						behavior = cmp.ConfirmBehavior.Replace,
						select = false,
					},
					['<Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end, { 'i', 's' }),
					['<S-Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { 'i', 's' }),
				}),
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				sources = cmp.config.sources {
					{ name = "nvim_lsp", priority = 1000 },
					{ name = "buffer",   priority = 500 },
					{ name = "path",     priority = 250 },
					{ name = "copilot",  priority = 100 },
				},
			}
		end,
	}
}

return M
