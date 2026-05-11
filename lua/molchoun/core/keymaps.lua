-- [[ Basic Keymaps ]]
--  See `:help map()`

local map = vim.keymap.set

map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map('n', '<C-h>', '<C-W>h', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Center after <C-d>
map('n', '<C-u>', '<C-u>zz')
map('n', '<C-d>', '<C-d>zz')
map('n', 'J', 'mzJ`z')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- Split window management
map('n', '<leader>sv', '<C-w>v', { desc = 'Split window vertically' })
map('n', '<leader>hs', '<C-w>s', { desc = 'Split window horizontally' })
map('n', '<leader>sx', '<cmd>close<CR>', { desc = 'Close window' })
map('n', '<leader>se', '<C-w>=', { desc = 'Equalize window sizes' })
map('n', '<leader>sm', '<C-w>|', { desc = 'Maximize window' })

-- Tab management
map('n', '<leader>to', '<cmd>tabnew<CR>', { desc = 'New tab' })
map('n', '<leader>tx', '<cmd>tabclose<CR>', { desc = 'Close tab' })
map('n', '<leader>tn', '<cmd>tabnext<CR>', { desc = 'Next tab' })
map('n', '<leader>tp', '<cmd>tabprevious<CR>', { desc = 'Previous tab' })

-- Ex remap
map('n', '<leader>pv', vim.cmd.Ex)

map('n', '<C-f>', function()
  if vim.env.TMUX and vim.env.TMUX ~= '' then
    vim.fn.jobstart({
      'tmux',
      'new-window',
      vim.fn.expand '$HOME/.local/bin/tmux-sessionizer',
    }, { detach = true })
  else
    vim.notify('tmux-sessionizer mapping requires Neovim running inside tmux', vim.log.levels.WARN)
  end
end, { desc = 'tmux sessionizer' })

map('x', '<leader>p', [["_dP]])
map({ 'n', 'v' }, '<leader>y', [["+y]])
map('n', '<leader>Y', [["+Y]])

map('n', '<leader>u', vim.cmd.UndotreeToggle)

map('v', '>', '>gv')
map('v', '<', '<gv')

-- Debug adapter DAP
map('n', '<leader>db', ':DapToggleBreakpoint<CR>', { noremap = true })
map('n', '<leader>dc', ':DapContinue<CR>', { noremap = true })
map('n', '<leader>do', ':lua require("dapui").open()<CR>', { noremap = true, silent = true })

-- Movement in insert mode
map('i', '<C-h>', '<Left>', { noremap = true })
map('i', '<C-l>', '<Right>', { noremap = true })
map('i', '<C-j>', '<Down>', { noremap = true })
map('i', '<C-k>', '<Up>', { noremap = true })
map('i', 'jj', '<Esc>', { noremap = true, silent = true })

-- Git
map('n', '<leader>gb', ':Git blame<CR>', { noremap = true, silent = true, desc = 'Toggle Git Blame' })
map('n', '<leader>gd', ':Gdiffsplit<CR>', { noremap = true, silent = true, desc = 'Git Diff split vertically' })

-- LSP
-- code actions
map('n', '<leader>vca', ':lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true, desc = 'Code Action' })

-- Move lines up and down
map('n', 'J', ':m .+1<CR>==', { noremap = true, silent = true, desc = 'Move line down' })
map('n', 'K', ':m .-2<CR>==', { noremap = true, silent = true, desc = 'Move line up' })
map('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = 'Move line down' })
map('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = 'Move line up' })

-- Run current python file
local virtualenv = os.getenv 'VIRTUAL_ENV' or '/usr'
local function rerun_python()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == 'terminal' then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
  vim.cmd('split | term ' .. virtualenv .. '/bin/python3 ' .. vim.fn.expand('%'))
end

-- Map the function to <leader>rp
map('n', '<leader>rp', rerun_python, { noremap = true, silent = true, desc = 'Run Python file in terminal' })

-- Dismiss message
map('n', '<leader>nd', ':echo<CR>', { noremap = true, silent = true, desc = 'Noop' })


local function create_py_init()
  local current_dir = vim.fn.expand("%:p:h")
  local rel_dir = vim.fn.fnamemodify(current_dir, ":.")

  local filepath = current_dir .. "/__init__.py"
  if vim.fn.filereadable(filepath) == 1 then
    vim.notify("__init__.py already exists in " .. rel_dir, vim.log.levels.WARN)
    return
  end

  local file = io.open(filepath, "w")
  if file then
    file:close()
    vim.notify("Created __init__.py in ./" .. rel_dir, vim.log.levels.INFO)
  else
    vim.notify("Failed to create __init__.py", vim.log.levels.ERROR)
  end
end

vim.keymap.set(
  "n",
  "<leader>ii",
  create_py_init,
  { noremap = true, silent = true }
)
