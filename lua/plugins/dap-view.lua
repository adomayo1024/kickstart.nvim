return {
  'igorlfs/nvim-dap-view',
  config = function()
    local dap_view = require 'dap-view'
    dap_view.setup {
      winbar = {
        show = true,
        sections = { 'watches', 'scopes', 'exceptions', 'breakpoints', 'threads', 'repl', 'memory' },
        default_section = 'scopes',
      },
      windows = {
        size = 0.50,
        position = 'right',
        terminal = {
          hide = true,
        },
      },
    }

    local dap = require 'dap'
    dap.listeners.after.event_initialized['dap-view'] = function(_, _) dap_view.open() end
    dap.listeners.before.event_terminated['dap-view'] = function(_, _) dap_view.close() end
    dap.listeners.before.event_exited['dap-view'] = function(_, _) dap_view.close() end
  end,
}
