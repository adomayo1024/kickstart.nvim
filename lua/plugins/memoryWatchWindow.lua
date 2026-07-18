return {
  dir = '/home/adomayo1024/programming/nvimPlugin/memoryWatchWindow.nvim',
  config = function() require('memoryWatchWindow').setup() end,
  dependencies = {
    'igorlfs/nvim-dap-view',
  },
}
