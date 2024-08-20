return {
	{
		"vim-test/vim-test",
		config = function()
			vim.keymap.set("n", "<leader>n", "<cmd>TestNearest<CR>")
			vim.keymap.set("n", "<leader>m", "<cmd>TestFile<CR>")
		end,
	},
}
