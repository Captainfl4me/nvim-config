local M = {
	'akinsho/bufferline.nvim',
	version = "*", 
	dependencies = 'nvim-tree/nvim-web-devicons',
	lazy = false,
	opts = {
		options = {
			offsets = {
				{
					filetype = "neo-tree",
					text = "File Explorer",
					text_align = "center",
					separator = true
				}
			},
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count, level, diagnostics_dict, context)
			  local icon = level:match("error") and " " or " "
			  return " " .. icon .. count
			end
		}
	}
}

return M
