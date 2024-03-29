local M = {
	'rebelot/kanagawa.nvim',
	lazy = not (ColorScheme == "kanagawa"),
	priority = 1000,
	config = function()
		require('kanagawa').setup({
			compile = true, -- enable compiling the colorscheme
			undercurl = true, -- enable undercurls
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = {},
			transparent = IsTransparent, -- do not set background color
			dimInactive = false, -- dim inactive window `:h hl-NormalNC`
			terminalColors = true, -- define vim.g.terminal_color_{0,17}
			colors = {          -- add/modify theme and palette colors
				palette = {},
				theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
			},
			overrides = function(_) -- add/modify highlights
				return {}
			end,
			background = { -- map the value of 'background' option to a theme
				dark = "wave", -- try "dragon" !
				light = "lotus"
			},
		})

		-- Loading colorscheme
		if ColorScheme == "kanagawa" then
			vim.cmd("colorscheme kanagawa")
		end
	end
}

return M
