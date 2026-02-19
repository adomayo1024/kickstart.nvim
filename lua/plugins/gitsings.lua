return { -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup {
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Next Hunk' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Previos Hunk' })

        -- Actions
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'stage Hunk' })
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'reset Hunk' })

        map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'stage Hunk' })

        map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'reset Hunk' })

        map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'stage Buffer' })
        map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'reset Buffer' })
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'preview hunk' })
        map('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = 'preview Hunk Inline' })

        map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end, { desc = 'blame Line' })

        map('n', '<leader>hd', gitsigns.diffthis, { desc = 'see diff of Buffer' })

        map('n', '<leader>hD', function() gitsigns.diffthis '~' end, { desc = 'see diff of Buffer' })

        map('n', '<leader>hQ', function() gitsigns.setqflist 'all' end)
        map('n', '<leader>hq', gitsigns.setqflist)

        -- Toggles
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
        map('n', '<leader>tw', gitsigns.toggle_word_diff)

        -- Text object
        map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
      end,
    }
  end,
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
  },
}
