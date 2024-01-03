--
-- Settings
--
local opt = vim.opt

-- Indentation
opt.autoindent = true
opt.cursorline = true
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
opt.smarttab = true
opt.tabstop = 4

-- UI
opt.laststatus = 2
opt.listchars = "tab:»·,trail:·"
opt.list = true
opt.number = true
opt.ruler = true
opt.splitbelow = true
opt.splitright = true

--
-- Keymaps
--
local key = vim.keymap
local silent = { silent = true }

vim.g.mapleader = " "

-- Easier pane navigation
key.set("n", "<C-h>", "<C-w>h")
key.set("n", "<C-j>", "<C-w>j")
key.set("n", "<C-k>", "<C-w>k")
key.set("n", "<C-l>", "<C-w>l")

-- Easier buffer switching
key.set("n", "<Leader><Left>", ":bp<CR>", silent)
key.set("n", "<Leader><Right>", ":bn<CR>", silent)

-- Source current file
key.set("n", "<Leader>s", ":so %<CR>", silent)

-- Quick-save
key.set("n", "<Leader>w", ":w<CR>")

-- Sharp exit
key.set("n", "<Leader>qq", ":qa!<CR>")

-- Toggle read-only buffer
key.set("n", "<Leader>ro", ":set ma!<CR>", silent)

-- Toggle search highlights
key.set("n", "<Leader>n", ":set nohls!<CR>", silent)

--
-- Colourscheme and tweaks
--
vim.cmd [[
colorscheme wildcharm
hi LineNr           ctermfg=darkcyan    ctermbg=NONE
hi StatusLine       ctermfg=lightgrey   ctermbg=darkblue    cterm=NONE
hi StatusLineNC     ctermfg=black       ctermbg=darkgray    cterm=NONE
hi CursorLine       ctermfg=NONE        ctermbg=NONE        cterm=underline
hi VertSplit        ctermfg=darkgray    ctermbg=NONE        cterm=NONE
hi Function         ctermfg=NONE        ctermbg=NONE        cterm=bold
]]

--
-- Autocommands
--
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Cursorline follows active window
autocmd("WinEnter", {
  pattern = "",
  command = [[:set cursorline]]
})

autocmd("WinLeave", {
  pattern = "",
  command = [[:set nocursorline]]
})

-- Strip trailing whitespace on save
autocmd("BufWritePre", {
  pattern = "",
  command = [[:%s/\s+$//e]]
})

-- C files
--
augroup('c-settings', { clear = true })
-- Format files on save
autocmd("BufWritePre", {
  group = 'c-settings',
  pattern = { "*.c", "*.h" },
  command = [[:%!clang-format]]
})

-- Lua files
--
augroup('lua-settings', { clear = true })
-- 2 space indents
autocmd("Filetype", {
  group = 'lua-settings',
  pattern = { "lua" },
  command = [[setlocal shiftwidth=2 tabstop=2]]
})

