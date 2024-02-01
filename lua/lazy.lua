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
	},
	{
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup()
		end
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
		  "nvim-lua/plenary.nvim",
		  "MunifTanjim/nui.nvim",
		  -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		}
	}
}

local opts = {
}

require("lazy").setup(plugins, opts)
