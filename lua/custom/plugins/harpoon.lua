return {
  'ThePrimeagen/harpoon',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local harpoon_mark = require 'harpoon.mark'
    local harpoon_ui = require 'harpoon.ui'
    vim.keymap.set('n', '<C-j>', function()
      harpoon_mark.add_file()
    end, { desc = 'Harpoon: Add file' })

    -- Shows the quick menu in the native view.
    vim.keymap.set('n', '<leader>j', function()
      harpoon_ui.toggle_quick_menu()
    end, { desc = 'Harpoon: Toggle buffer menu' })

    -- Shows the quick menu in a telescope view.
    -- vim.keymap.set('n', '<leader>j', '<cmd>Telescope harpoon marks<cr>', { desc = 'Harpoon: Toggle buffer menu' })

    vim.keymap.set('n', '<C-l>', function()
      harpoon_ui.nav_next()
    end, { desc = 'Harpoon: Navigate to previous buffer' })

    vim.keymap.set('n', '<C-h>', function()
      harpoon_ui.nav_prev()
    end, { desc = 'Harpoon: Navigate to next buffer' })

    for i = 0, 9, 1 do
      vim.keymap.set('n', '<leader>' .. i, function()
        harpoon_ui.nav_file(i)
      end, { desc = 'which_key_ignore' })
    end

    require('telescope').load_extension 'harpoon'
  end,
}
