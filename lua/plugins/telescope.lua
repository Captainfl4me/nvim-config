local M = {
	'nvim-telescope/telescope.nvim',
	-- commit = 'dc7f25c', --tag = '0.1.5',
	dependencies = { 
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope-ui-select.nvim'
	},
	cmd = {
		"Telescope"
	},
	keys = {
		{
			'<leader>ff',
			'<cmd>Telescope find_files<cr>',
			desc = "Telescope find files"
		},
		{
			'<leader>fg',
			'<cmd>Telescope live_grep<cr>',
			desc = "Telescope grep files"
		},
		{
			'<leader>fb',
			'<cmd>Telescope buffers<cr>',
			desc = "Telescope navigate buffers"
		},
		{
			'<leader>fh',
			'<cmd>Telescope help_tags<cr>',
			desc = "Telescope navigate help"
		},
		{
			'<leader>d',
			function() require('telescope.builtin').diagnostics({ line_width = 'full', severity_bound = 0 }) end,
			desc = "Telescope display diagnostic"
		},
		{
			'gd',
			'<cmd>Telescope lsp_definitions<cr>',
			desc = "Telescope goto definition(s)"
		},
		{
			'gi',
			'<cmd>Telescope lsp_implementations<cr>',
			desc = "Telescope goto implementation(s)"
		},
		{
			'gr',
			'<cmd>Telescope lsp_references<cr>',
			desc = "Telescope goto reference(s)"
		},
	},
	opts = {
		defaults = { wrap_results = true }
	},
	config = function ()
		require("telescope").load_extension("ui-select")
	end
}

return M
