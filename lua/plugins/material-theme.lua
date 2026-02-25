return {
	"marko-cerovac/material.nvim",
	lazy = false, -- optional: load immediately
	priority = 1000, -- optional: ensures theme loads before other plugins
	config = function()
		-- optional configuration
		vim.g.material_style = "deep ocean" -- example style
		require("material").setup({
			-- your options here
		})
		-- vim.cmd.colorscheme("material")
	end,
}
