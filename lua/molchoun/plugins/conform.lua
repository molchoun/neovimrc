return { -- Autoformat
  'stevearc/conform.nvim',
  lazy = false,
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    -- format_on_save = function(bufnr)
    --   local disable_filetypes = { c = true, cpp = true }
    --   return {
    --     timeout_ms = 500,
    --     lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
    --     undojoin = true,
    --   }
    -- end,
    formatters_by_ft = {
      css = { 'prettierd' },
      html = { 'prettierd' },
      php = { 'php' },
      lua = { 'stylua' },
      python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' }, -- Use ruff for imports, black for formatting
      json = { 'deno_fmt' },
    },
    formatters = {
      black = {
        prepend_args = {
          '--line-length',
          '88', -- Match your pyproject.toml
          '--target-version',
          'py311',
        },
      },
      php = {
        command = 'php-cs-fixer',
        args = {
          'fix',
          '$FILENAME',
          '--config=/your/path/to/config/file/[filename].php',
          '--allow-risky=yes', -- if you have risky stuff in config, if not you dont need it.
        },
        stdin = false,
      },
    },
  },
}
