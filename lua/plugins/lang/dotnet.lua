return {
  {
    'seblyng/roslyn.nvim',
    ft = { 'cs', 'razor' },
    dependencies = { 'hrsh7th/cmp-nvim-lsp' },
    init = function()
      vim.filetype.add {
        extension = {
          razor = 'razor',
          cshtml = 'razor',
        },
      }
    end,
    config = function()
      local config = {
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        settings = {
          ['csharp|inlay_hints'] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_indexer_parameters = true,
            dotnet_enable_inlay_hints_for_literal_parameters = true,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
            dotnet_enable_inlay_hints_for_other_parameters = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
          },
          ['csharp|code_lens'] = {
            dotnet_enable_references_code_lens = true,
          },
        },
      }

      local roslyn = vim.fn.exepath 'roslyn'
      if roslyn ~= '' then
        config.cmd = { roslyn, '--stdio' }
      end

      vim.lsp.config('roslyn', config)
      require('roslyn').setup {}
    end,
  },
  {
    'mfussenegger/nvim-dap',
    ft = { 'cs', 'razor' },
    config = function()
      local dap = require 'dap'
      local netcoredbg = vim.fn.exepath 'netcoredbg'
      if netcoredbg == '' then
        netcoredbg = vim.fs.joinpath(vim.fn.stdpath 'data' --[[@as string]], 'mason', 'bin', 'netcoredbg')
      end

      dap.adapters.netcoredbg = {
        type = 'executable',
        command = netcoredbg,
        args = { '--interpreter=vscode' },
      }
      dap.configurations.cs = {
        {
          type = 'netcoredbg',
          name = 'launch - netcoredbg',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
          end,
        },
      }
    end,
  },
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
    keys = {
      {
        '<leader>tr',
        function()
          require('neotest').run.run()
        end,
        desc = 'Run closest test',
      },
      {
        '<leader>td',
        function()
          require('neotest').run.run { strategy = 'dap' }
        end,
        desc = 'Debug closest test',
      },
      {
        '<leader>tt',
        function()
          require('neotest').summary.toggle()
        end,
        desc = 'Open test summary',
      },
      {
        '<leader>to',
        function()
          require('neotest').output.open { enter = true }
        end,
        desc = 'Open test output',
      },
    },
    opts = function()
      return {
        adapters = { require 'neotest-dotnet' },
      }
    end,
  },
}
