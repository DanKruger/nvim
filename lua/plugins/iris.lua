return {
	{
		name = "iris-nvim",
		dir = "/Users/daniel/code/toris/iris-nvim",
		lazy = false,
		priority = 100,
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("iris").setup()
		end,
	},
}
