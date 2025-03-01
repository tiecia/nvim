return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'Issafalcon/neotest-dotnet',
      'mortepau/codicons.nvim',
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-dotnet',
          -- require 'neotest-plenary',
        },
      }

      local neotest = require 'neotest'
      vim.keymap.set('n', '<leader>tr', function()
        neotest.run.run()
      end, { desc = 'Run Closest Test' })

      vim.keymap.set('n', '<leader>tt', function()
        neotest.summary.toggle()
      end, { desc = 'Open test summary' })
    end,
  },
}
