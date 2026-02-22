require 'config/options'
require 'config/keymap'
require 'config/autocmd'
require 'config/lazy-bootstrap'
require('lazy').setup('plugins', {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {},
  },
})
-- vim: ts=2 sts=2 sw=2 et
