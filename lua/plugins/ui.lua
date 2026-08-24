return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle/[T]est' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },
  {
    'lewis6991/hover.nvim',
    init = function()
      vim.o.mousemoveevent = true
    end,
    keys = {
      {
        'K',
        function()
          require('hover').hover()
        end,
        desc = 'hover.nvim',
      },
      {
        'gK',
        function()
          require('hover').hover_select()
        end,
        desc = 'hover.nvim (select)',
      },
      {
        '<C-n>',
        function()
          require('hover').hover_switch 'next'
        end,
        desc = 'hover.nvim (next source)',
      },
      {
        '<MouseMove>',
        function()
          require('hover').hover_mouse()
        end,
        desc = 'hover.nvim (mouse)',
      },
    },
    opts = {
      init = function()
        require 'hover.providers.lsp'
      end,
      preview_opts = { border = 'single' },
      preview_window = false,
      title = true,
      mouse_providers = { 'LSP' },
      mouse_delay = 1000,
    },
  },
  {
    'LunarVim/darkplus.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'darkplus'
    end,
  },
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  {
    'nvim-mini/mini.nvim',
    config = function()
      require('mini.icons').setup()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()

      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },
}
