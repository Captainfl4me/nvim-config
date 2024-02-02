local M = {
    "nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	cmd = {
		"TSBufDisable",
		"TSBufEnable",
		"TSBufToggle",
		"TSDisable",
		"TSEnable",
		"TSToggle",
		"TSInstall",
		"TSInstallInfo",
		"TSInstallSync",
		"TSModuleInfo",
		"TSUninstall",
		"TSUpdate",
		"TSUpdateSync",
	  },
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
    end,
	config = function ()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = {
				"c",
				"cpp",
				"cmake",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"python",
				"rust",
				"html",
				"css",
				"scss",
				"javascript",
				"typescript",
				"json",
				"markdown",
				"markdown_inline",
				"regex",
				"latex",
			},

			sync_install = false,
			auto_install = true,
			context_commentstring = { enable = true, enable_autocmd = false },
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
			ignore_install = {},
			modules = {},
		})
    end
}

return M
