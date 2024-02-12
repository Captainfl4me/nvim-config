local M = {
	"folke/tokyonight.nvim",
	lazy = not (ColorScheme == "tokyonight"),
	priority = 1000,
	opts = function()
		return {
			style = "moon",
			transparent = IsTransparent,
			styles = {},
		}
	end,

	config = function(_, opts)
		local tokyonight = require("tokyonight")
		tokyonight.setup(opts)
		tokyonight.load()

		if ColorScheme == "tokyonight" then
			vim.cmd("colorscheme tokyonight")
		end
	end,
}

return M
