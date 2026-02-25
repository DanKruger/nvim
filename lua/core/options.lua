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
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.termguicolors = true
vim.o.background = "dark" -- set background to dark version of theme

vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split" -- Preview substitutions live, as you type!
vim.opt.cursorline = true -- Show which line your cursor is on
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

local no_fold_filetypes = {
	alpha = true,
	checkhealth = true,
	help = true,
	lazy = true,
	mason = true,
	noice = true,
	oil = true,
	qf = true,
	snacks_dashboard = true,
	snacks_notif = true,
	snacks_win = true,
	TelescopePrompt = true,
}

local function setup_buffer_folds(bufnr)
	local ft = vim.bo[bufnr].filetype
	if no_fold_filetypes[ft] then
		vim.opt_local.foldmethod = "manual"
		vim.opt_local.foldexpr = "0"
		vim.opt_local.foldenable = false
		return
	end

	local has_ts_parser = pcall(vim.treesitter.get_parser, bufnr)
	if has_ts_parser then
		vim.opt_local.foldmethod = "expr"
		vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
	else
		vim.opt_local.foldmethod = "indent"
		vim.opt_local.foldexpr = "0"
	end
	vim.opt_local.foldenable = true
end

vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, {
	desc = "Use treesitter folds with indent fallback",
	group = vim.api.nvim_create_augroup("folding-setup", { clear = true }),
	callback = function(event)
		setup_buffer_folds(event.buf)
	end,
})

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
