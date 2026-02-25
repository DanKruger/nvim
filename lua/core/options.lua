vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4 -- Tab size
vim.o.shiftwidth = 4 -- indent width
vim.o.scrolloff = 10
vim.o.softtabstop = 4
vim.o.expandtab = true -- Expand tab to spaces
vim.o.autoindent = true -- copy indent of current line to new line
vim.o.list = true

vim.o.updatetime = 100
vim.o.timeoutlen = 300
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.o.signcolumn = "yes"

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.termguicolors = true
vim.o.background = "dark" -- set background to dark version of theme

vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split" -- Preview substitutions live, as you type!
vim.opt.cursorline = true -- Show which line your cursor is on

vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
