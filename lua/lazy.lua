local plugins = {
	{
		'rebelot/kanagawa.nvim',
		lazy = false,
		priority = 1000,
		config = function()
			require("config.kanagawa")
		end
	},
	{
		'nvim-tree/nvim-web-devicons'
	},
	{
		'rebelot/heirline.nvim',
		lazy = false,
		priority = 1000,
		config = function()
			require("config.heirline")
		end
	}
}

local opts = {
}

require("lazy").setup(plugins, opts)
