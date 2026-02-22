-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic Config & Keymaps
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },

  -- Can switch between these as you prefer
  virtual_text = true, -- Text shows up at the end of the line
  virtual_lines = false, -- Teest shows up underneath the line, with virtual lines

  -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
  jump = { float = true },
}

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

--Neotree keymaps
--
vim.keymap.set('n', '<leader>no', '<cmd> Neotree toggle<CR>', { desc = 'Open Neotree window' })

--Git keymaps
vim.keymap.set('n', '<leader>gc', function() vim.cmd 'Git commit' end, { desc = 'Git commit' })
vim.keymap.set('n', '<leader>ga', function()
  vim.ui.input({ prompt = 'Git add path: ' }, function(input)
    if not input or input == '' then return end
    vim.cmd('Git add ' .. vim.fn.shellescape(input))
  end)
end, { desc = 'Git add (prompt)' })

vim.keymap.set('n', '<leader>gA', function()
  require('telescope.builtin').git_status {
    attach_mappings = function(prompt_bufnr, map)
      local actions = require 'telescope.actions'
      local action_state = require 'telescope.actions.state'

      local function git_add_selected()
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.cmd('Git add ' .. vim.fn.shellescape(entry.value))
      end

      map('i', '<CR>', git_add_selected)
      map('n', '<CR>', git_add_selected)
      return true
    end,
  }
end, { desc = 'Git add via Telescope' })

vim.keymap.set('n', '<leader>gp', function()
  local function has_upstream()
    local result = vim.fn.system {
      'git',
      'rev-parse',
      '--abbrev-ref',
      '--symbolic-full-name',
      '@{u}',
    }
    return vim.v.shell_error == 0
  end

  if has_upstream() then
    vim.cmd 'Git push'
  else
    vim.cmd 'Git push -u origin HEAD'
  end
end, { desc = 'Git push' })

vim.keymap.set('n', '<leader>gdb', function()
  vim.ui.input({ prompt = 'Git delete branch: ' }, function(input)
    if not input or input == '' then return end
    vim.cmd('Git add ' .. vim.fn.shellescape(input))
    vim.cmd('Git push origin --delete ' .. vim.fn.shellescape(input))
  end)
end, {desc = "Deleted branch lokal and remote" })
