return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")

		-- this is where you add language support for highlighting and syntax
		config.setup({
			ensure_installed = { "javascript", "html", "css", "python", "lua", "xml", "json" },
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
