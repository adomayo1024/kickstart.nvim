return {
  'mfussenegger/nvim-jdtls',
  ft = 'java',
  dependencies = { 'mfussenegger/nvim-dap' },
  config = function()
    local function attach_jdtls()
      local jdtls = require 'jdtls'
      local mason = vim.fn.stdpath 'data' .. '/mason/packages'

      local bundles = {
        vim.fn.glob(mason .. '/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar', true),
      }
      vim.list_extend(bundles, vim.split(vim.fn.glob(mason .. '/java-test/extension/server/*.jar', true), '\n'))

      local root_dir = vim.fs.root(0, { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' })
      local project_name = vim.fn.fnamemodify(root_dir or vim.fn.getcwd(), ':t')
      local workspace_dir = vim.fn.stdpath 'data' .. '/jdtls-workspace/' .. project_name

      jdtls.start_or_attach {
        cmd = { vim.fn.exepath 'jdtls', '-data', workspace_dir },
        root_dir = root_dir,
        init_options = { bundles = bundles },
        on_attach = function()
          jdtls.setup_dap { hotcodereplace = 'auto' }
          require('jdtls.dap').setup_dap_main_class_configs()
        end,
      }
    end

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'java',
      callback = attach_jdtls,
    })

    -- Der FileType-Event für den aktuellen Buffer ist beim Laden des Plugins
    -- oft schon gefeuert, daher einmal direkt aufrufen
    if vim.bo.filetype == 'java' then attach_jdtls() end

    vim.keymap.set('n', '<leader>tc', require('jdtls').test_class)
    vim.keymap.set('n', '<leader>tm', require('jdtls').test_nearest_method)
  end,
}
