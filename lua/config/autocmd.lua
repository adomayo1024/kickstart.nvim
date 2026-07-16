-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- ändert die farbe des balken zur visualisierung von colorcolumn
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function() vim.api.nvim_set_hl(0, 'ColorColumn', { bg = '#2d3139' }) end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'tex',
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { 'de' }
  end,
})
