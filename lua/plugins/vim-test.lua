return {
	{
		"vim-test/vim-test",
		config = function()
			vim.keymap.set("n", "<leader>n", ":TestNearest<CR>")
			vim.keymap.set("n", "<leader>m", ":TestFile<CR>")
		end,
	},
}
