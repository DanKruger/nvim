return {
	"marko-cerovac/material.nvim",
	lazy = true,
	config = function()
		vim.g.material_style = "deep ocean"
		require("material").setup({})
	end,
}
