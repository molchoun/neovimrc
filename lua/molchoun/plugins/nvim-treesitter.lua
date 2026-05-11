return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
  config = function()
    local ts = require 'nvim-treesitter'
    local local_bin = vim.fn.expand '$HOME/.local/bin'
    local languages = {
      'bash',
      'diff',
      'html',
      'json',
      'lua',
      'luadoc',
      'markdown',
      'python',
      'vim',
      'vimdoc',
      'yaml',
    }

    if not vim.env.PATH:match(vim.pesc(local_bin)) then
      vim.env.PATH = local_bin .. ':' .. vim.env.PATH
    end

    ts.setup {
      install_dir = vim.fn.stdpath 'data' .. '/site',
    }

    local installed = ts.get_installed()
    local missing = vim.tbl_filter(function(lang)
      return not vim.list_contains(installed, lang)
    end, languages)

    if #missing > 0 then
      ts.install(missing, { summary = true })
    end

    vim.api.nvim_create_autocmd('FileType', {
      pattern = languages,
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
