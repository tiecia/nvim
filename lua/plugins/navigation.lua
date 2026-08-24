local harpoon_keys = {
  {
    '<C-j>',
    function()
      require('harpoon.mark').add_file()
    end,
    desc = 'Harpoon: Add file',
  },
  {
    '<leader>j',
    function()
      require('harpoon.ui').toggle_quick_menu()
    end,
    desc = 'Harpoon: Toggle buffer menu',
  },
  {
    '<C-l>',
    function()
      require('harpoon.ui').nav_next()
    end,
    desc = 'Harpoon: Navigate to next buffer',
  },
  {
    '<C-h>',
    function()
      require('harpoon.ui').nav_prev()
    end,
    desc = 'Harpoon: Navigate to previous buffer',
  },
}

for index = 0, 9 do
  local target = index
  table.insert(harpoon_keys, {
    '<leader>' .. target,
    function()
      require('harpoon.ui').nav_file(target)
    end,
    desc = 'which_key_ignore',
  })
end

return {
  {
    'nvim-telescope/telescope.nvim',
    branch = 'master',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      'nvim-telescope/telescope-ui-select.nvim',
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      local telescope = require 'telescope'
      local builtin = require 'telescope.builtin'
      local themes = require 'telescope.themes'

      telescope.setup {
        extensions = {
          ['ui-select'] = { themes.get_dropdown() },
        },
      }
      pcall(telescope.load_extension, 'fzf')
      pcall(telescope.load_extension, 'ui-select')

      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(themes.get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
  {
    'ThePrimeagen/harpoon',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    keys = harpoon_keys,
    config = function()
      require('telescope').load_extension 'harpoon'
    end,
  },
  {
    'stevearc/oil.nvim',
    lazy = false,
    opts = {},
    keys = {
      {
        '<leader>p',
        function()
          require('oil').open()
        end,
        desc = 'Open file explorer',
      },
    },
  },
  {
    'glepnir/template.nvim',
    main = 'template',
    cmd = { 'Template', 'TemProject' },
    opts = function()
      return {
        temp_dir = vim.fs.joinpath(vim.fn.stdpath 'config' --[[@as string]], 'templates'),
      }
    end,
  },
}
