local ensure_installed = require 'mason-lspconfig.ensure_installed'
-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

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
        print 'Run closest test'
        neotest.run.run()
      end, { desc = '[T]est [R]un Closest Test' })

      vim.keymap.set('n', '<leader>tt', function()
        print 'Toggle test window'
        neotest.summary.toggle()
      end, { desc = 'Open test summary' })
    end,
  },

  {
    'seblyng/roslyn.nvim',
    ft = { 'cs', 'razor' },
    dependencies = {
      -- Mason with the registey github:Crashdummyy/mason-registry should be listed as a dependency, but that seems to override other mason configurations.
      'tris203/rzls.nvim',
      config = function()
        ---@diagnostic disable-next-line: missing-fields
        require('rzls').setup {}
      end,
    },
    opts = {
      -- your configuration comes here; leave empty for default settings_split_by_newline
    },
    config = function()
      require('roslyn').setup {
        args = {
          '--stdio',
          '--logLevel=Information',
          '--extensionLogDirectory=' .. vim.fs.dirname(vim.lsp.get_log_path()),
          '--razorSourceGenerator='
            .. vim.fs.joinpath(vim.fn.stdpath 'data' --[[@as string]], 'mason', 'packages', 'roslyn', 'libexec', 'Microsoft.CodeAnalysis.Razor.Compiler.dll'),
          '--razorDesignTimePath=' .. vim.fs.joinpath(
            vim.fn.stdpath 'data' --[[@as string]],
            'mason',
            'packages',
            'rzls',
            'libexec',
            'Targets',
            'Microsoft.NET.Sdk.Razor.DesignTime.targets'
          ),
        },
        config = {
          --[[ the rest of your roslyn config ]]
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
          handlers = require 'rzls.roslyn_handlers',
        },
      }
    end,
    init = function()
      vim.filetype.add {
        extension = {
          razor = 'razor',
          cshtml = 'razor',
        },
      }
    end,
  },
}
