local pattern = '([^:]+):(%d+):(%d+):(%d+):(%d+): (%a+): (.*) %[(%a[%a-]+)%]'
local groups = { 'file', 'lnum', 'col', 'end_lnum', 'end_col', 'severity', 'message', 'code' }
local severities = {
  error = vim.diagnostic.severity.ERROR,
  warning = vim.diagnostic.severity.WARN,
  note = vim.diagnostic.severity.HINT,
}

return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      local virtual_env = os.getenv 'VIRTUAL_ENV' or '/usr/bin/python3'
      lint.linters.mypy = {
        name = 'mypy',
        cmd = 'mypy',
        stdin = false,
        ignore_exitcode = true,
        args = {
          '--show-column-numbers',
          '--show-error-end',
          '--hide-error-context',
          '--no-color-output',
          '--no-error-summary',
          '--no-pretty',
          '--install-types',
          '--python-executable',
          function()
            return virtual_env .. '/bin/python3' or vim.fn.exepath 'python3'
          end,
        },
        parser = require('lint.parser').from_pattern(pattern, groups, severities, { ['source'] = 'mypy' }, { end_col_offset = 0 }),
      }
      lint.linters_by_ft = {
        css = { 'stylelint' },
        html = { 'htmlhint' },
        php = { 'php' },
        python = { 'ruff' },

      }

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave', 'BufLeave', 'InsertLeave', 'TextChanged', 'User' }, {
        group = lint_augroup,
        callback = function()
          require('lint').try_lint(nil, { ignore_errors = true })
        end,
      })
    end,
  },
}
