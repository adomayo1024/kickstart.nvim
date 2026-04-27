return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    -- Required for eslint_d and prettierd sources.
    'nvimtools/none-ls-extras.nvim',
  },
  config = function()
    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    local null_ls = require 'null-ls'

    null_ls.setup {
      sources = {
        require 'none-ls.diagnostics.eslint_d',
        require 'none-ls.formatting.eslint_d',
        null_ls.builtins.formatting.prettierd,
      },

      -- Format on save.
      -- Source: https://github.com/nvimtools/none-ls.nvim/wiki/Formatting-on-save
      on_attach = function(client, bufnr)
        if client.supports_method 'textDocument/formatting' then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function() vim.lsp.buf.format { async = false } end,
          })
        end
      end,
    }
  end,
}
