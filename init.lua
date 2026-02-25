vim.g.have_nerd_font = true

vim.g.netrw_liststyle = 3
vim.g.mapleader = " " -- Set the leader key
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.g.breakindent = true
vim.g.undofile = true -- Save undo history

vim.hl.priorities.semantic_tokens = 95

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "<filetype>" },
	callback = function()
		vim.treesitter.start()
	end,
})

require("core.options")
require("core.keymaps")
require("config.lazy")
