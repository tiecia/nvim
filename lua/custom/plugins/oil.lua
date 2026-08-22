return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  config = function(_, opts)
    local oil = require 'oil'
    oil.setup(opts)
    vim.keymap.set('n', '<leader>p', function()
      oil.open()
    end, { desc = 'Open file explorer' })
  end,
}
