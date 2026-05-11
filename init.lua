-- Options
require ("molchoun.core")

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Lazy
-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
require("molchoun.lazy")

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Work around broken markdown ftplugin mappings',
  group = vim.api.nvim_create_augroup('molchoun-markdown-ft', { clear = true }),
  pattern = 'markdown',
  callback = function(event)
    local opts = { buffer = event.buf, silent = true }
    vim.keymap.set('n', 'gO', function()
      pcall(require('vim.treesitter._headings').show_toc)
    end, vim.tbl_extend('force', opts, { desc = 'Show an Outline of the current buffer' }))

    vim.keymap.set('n', ']]', function()
      pcall(function()
        require('vim.treesitter._headings').jump({ count = 1 })
      end)
    end, vim.tbl_extend('force', opts, { silent = false, desc = 'Jump to next section' }))

    vim.keymap.set('n', '[[', function()
      pcall(function()
        require('vim.treesitter._headings').jump({ count = -1 })
      end)
    end, vim.tbl_extend('force', opts, { silent = false, desc = 'Jump to previous section' }))
  end,
})

vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
