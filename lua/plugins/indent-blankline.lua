return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {
      enabled = true,
      debounce = 200,
      viewport_buffer = {
        min = 30,
      },
      indent = {
        char = '│',
        tab_char = '│',
      },
      scope = {
        show_exact_scope = true,
        injected_languages = true,
      },
      exclude = {
        filetypes = { 'markdown', 'lspinfo', 'packer', 'checkhealth', 'help', 'man', 'gitcommit', 'TelescopePrompt', 'TelescopeResults', '' },
      },
    },
  },
}
