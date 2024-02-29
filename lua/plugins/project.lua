local M = {
	"ahmedkhalf/project.nvim",
	version = false,
	lazy = false,
	dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      { "<leader>fp", "<Cmd>Telescope projects<CR>", desc = "Projects" },
    },
	opts = {
		manual_mode = false,
		silent_chdir = true,
	},
	config = function(_, opts)
		opts.detection_methods = { "lsp", "pattern" }
        opts.patterns = {
			".git",
			".hg",
			".svn",
		}
		require("project_nvim").setup(opts)
		require("telescope").load_extension("projects")
    end,
}

return M
