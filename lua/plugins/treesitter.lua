local languages = require 'config.languages'

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    opts = {
      ensure_installed = languages.treesitter_parsers,
    },
    config = function(_, opts)
      local treesitter = require 'nvim-treesitter'
      treesitter.setup {}
      treesitter.install(opts.ensure_installed)

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('tiecia-treesitter', { clear = true }),
        callback = function(event)
          local language = vim.treesitter.language.get_lang(vim.bo[event.buf].filetype)
          local has_indent_query = language and vim.treesitter.query.get(language, 'indents') ~= nil
          if pcall(vim.treesitter.start, event.buf) and has_indent_query and vim.bo[event.buf].filetype ~= 'ruby' then
            vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    opts = {},
  },
}
