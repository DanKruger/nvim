vim.cmd("let g:netrw_liststyle = 3")
vim.g.mapleader = " " -- Set the leader key

local option = vim.opt
local keybind = vim.keymap

-- Indent configuration
option.tabstop = 4    -- Tab size
option.shiftwidth = 4 -- indent width
option.scrolloff = 10
option.softtabstop = 4
option.expandtab = true  -- Expand tab to spaces
option.autoindent = true -- copy indent of current line to new line

option.cursorline = true -- Highlight line cursor is on
option.updatetime = 100  -- Set buffer update time

-- Search settings
option.ignorecase = true -- Ignore case while searching
option.smartcase = true  -- if includes mixed case, assume you mean case sensitive

option.termguicolors = true
option.background = "dark" -- set background to dark version of theme

-- Clipboard configuration
option.clipboard:append("unnamedplus")

keybind.set("n", "<leader>w", ":w<CR>") -- Write File (Save)

-- Line number configuration
option.number = true
option.relativenumber = true
option.signcolumn = "auto:9"

--[[ option.statuscolumn = '%#NonText# %{&nu?v:lnum:""} %=' ]]

-- Tab navigation
keybind.set("n", "<A-j>", ":tabp<CR>") -- Switch to tab on left
keybind.set("n", "<A-k>", ":tabn<CR>") -- Switch to tab on right
keybind.set("n", "<A-t>", ":tabe<CR>") -- Create new tab
keybind.set("n", "<A-x>", ":tabc<CR>") -- Close current tab

-- Window management
option.splitright = true                -- Windows will split to the right
option.splitbelow = true                -- Windows will split below
keybind.set("n", "<leader>k", "<C-w>s") -- Create new window on the side
keybind.set("n", "<leader>j", "<C-w>v") -- Create new window below
keybind.set("n", "<leader>q", "<C-w>q") -- Close window (same as :q)

-- Window resizing
keybind.set("n", "<A-Right>", ":vert res +5<CR>") -- horizontally by 5
keybind.set("n", "<A-Up>", ":res +5<CR>")         -- vertically by 5
keybind.set("n", "<A-Down>", ":res -5<CR>")       -- vertically by -5

-- Clear search highlights
keybind.set("n", "<leader>h", ":nohl<CR>", { desc = "Clear search highlights" })
