return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				-- theme = "seoul256",
				theme = "material",
				component_separators = { left = "┊", right = "┊" },
				-- section_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
		})
	end,
}
