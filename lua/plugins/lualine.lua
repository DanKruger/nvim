return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "palenight",
				component_separators = { left = "│", right = "│" },
				section_separators = { left = "", right = "" },
				-- section_separators = { left = "" , right = "" },
				-- section_separators = { left = " ", right = "" },
			},
			sections = {
				lualine_x = {
					{
						require("noice").api.status.mode.get,
						cond = require("noice").api.status.mode.has,
						color = { fg = "#ff9e64" },
					},
				},
			},
		})
	end,
}
