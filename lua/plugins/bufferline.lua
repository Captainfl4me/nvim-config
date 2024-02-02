local M = {
	'akinsho/bufferline.nvim',
	version = "*", 
	dependencies = 'nvim-tree/nvim-web-devicons',
	lazy = false,
	config = function()
		require("bufferline").setup{
			options = {
				offsets = {
					{
						filetype = "neo-tree",
						text = "File Explorer",
						text_align = "center",
						separator = true
					}
				},
			}
		}
	end
}

return M
