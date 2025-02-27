local ensure_installed = require 'mason-lspconfig.ensure_installed'
-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'seblyng/roslyn.nvim',
    ft = 'cs',
    dependencies = {
      -- Mason with the registey github:Crashdummyy/mason-registry should be listed as a dependency, but that seems to override other mason configurations.
    },
    opts = {
      -- your configuration comes here; leave empty for default settings
    },

    -- 'iabdelkareem/csharp.nvim',
    -- dependencies = {
    --   'williamboman/mason.nvim',
    --   -- { 'williamboman/mason.nvim', opts = { ensure_installed = { 'csharpier', 'netcoredbg', 'omnisharp' } } },
    --   'mfussenegger/nvim-dap',
    --   'Tastyep/structlog.nvim', -- Optional, but highly recommended for debugging
    -- },
    -- config = function()
    --   require('mason').setup() -- Mason setup must run before csharp, only if you want to use omnisharp
    --   require('csharp').setup()
    -- end,
  },
}
