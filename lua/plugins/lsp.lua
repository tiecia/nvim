local languages = require 'config.languages'

return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      {
        'mason-org/mason.nvim',
        opts = {
          registries = {
            'github:mason-org/mason-registry',
            'github:Crashdummyy/mason-registry',
          },
        },
      },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      local lsp = require 'config.lsp'
      lsp.setup_attach()
      lsp.configure_diagnostics()

      local ensure_installed = vim.tbl_keys(languages.servers)
      vim.list_extend(ensure_installed, languages.mason_tools)

      require('mason-lspconfig').setup { automatic_enable = false }
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      local capabilities = lsp.capabilities()
      for server_name, server in pairs(languages.servers) do
        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
        vim.lsp.config(server_name, server)
        vim.lsp.enable(server_name)
      end
    end,
  },
}
