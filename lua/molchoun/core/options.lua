-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.guicursor = ''

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Fold settings
-- Set fold method to 'expr'
vim.o.foldmethod = 'expr'

-- Set fold expression to use nvim_treesitter
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldlevel = 99

-- Tabs and indentation
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.autoindent = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- Add relative line numbers
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'number'

-- Decrease update time
vim.opt.updatetime = 80

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
-- vim.opt.list = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = false

-- Incremental search
vim.opt.incsearch = true

-- Treat a dash (-) as part of a word
vim.opt.iskeyword:append '-'

-- Match classic terminal Vim colors instead of Neovim's GUI palette.
vim.opt.termguicolors = true

-- Use Neovim's built-in default colorscheme.
vim.cmd.colorscheme 'default'
