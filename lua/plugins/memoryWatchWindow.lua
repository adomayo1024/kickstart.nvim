return {
  'leon-scharnweber/nvim-dap-MemmoryWindow',
  config = function() require('memoryWatchWindow').setup() end,
  dependencies = {
    'igorlfs/nvim-dap-view',
  },
}
