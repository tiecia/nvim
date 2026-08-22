return {
  {
    'seblyng/roslyn.nvim',
    lazy = false,
    dependencies = { 'hrsh7th/cmp-nvim-lsp' },
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

      -- Mason's launcher invokes Roslyn through the `dotnet` on PATH, which
      -- works with system installations as well as Nix-wrapped SDKs.
      local roslyn = vim.fn.exepath 'roslyn'
      if roslyn ~= '' then
        config.cmd = { roslyn, '--stdio' }
      end

      vim.lsp.config('roslyn', config)
      require('roslyn').setup {}
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
