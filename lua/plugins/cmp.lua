local M = {
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
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

		},
		event = "InsertEnter",
		opts = function()

			-- luasnip setup
			local luasnip = require 'luasnip'

			-- nvim-cmp setup
			local cmp = require 'cmp'
			return {
				snippet = {
					expand = function(args)
					  luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
					['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
					-- C-b (back) C-f (forward) for snippet placeholder navigation.
					['<C-Space>'] = cmp.mapping.complete(),
					['<CR>'] = cmp.mapping.confirm {
					  behavior = cmp.ConfirmBehavior.Replace,
					  select = true,
					},
					['<Tab>'] = cmp.mapping(function(fallback)
					  if cmp.visible() then
						cmp.select_next_item()
					  elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					  else
						fallback()
					  end
					end, { 'i', 's' }),
					['<S-Tab>'] = cmp.mapping(function(fallback)
					  if cmp.visible() then
						cmp.select_prev_item()
					  elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
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
					{ name = "luasnip", priority = 750 },
					{ name = "buffer", priority = 500 },
					{ name = "path", priority = 250 },
					{ name = "copilot", priority = 100 },
				},
			}
		end,
	}
}

return M
