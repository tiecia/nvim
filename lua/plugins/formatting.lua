local languages = require 'config.languages'
local profile = require 'config.profile'

return {
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    cmd = 'ConformInfo',
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local lsp_format = profile.formatting.disabled_filetypes[vim.bo[bufnr].filetype] and 'never' or 'fallback'
        local path = vim.api.nvim_buf_get_name(bufnr)

        for _, fragment in ipairs(profile.formatting.excluded_path_fragments) do
          if path:find(fragment, 1, true) then
            lsp_format = 'never'
            break
          end
        end

        return {
          timeout_ms = 500,
          lsp_format = lsp_format,
        }
      end,
      formatters_by_ft = languages.formatters_by_ft,
    },
  },
}
