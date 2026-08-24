local M = {}

M.servers = {
  lua_ls = {
    settings = {
      Lua = {
        completion = { callSnippet = 'Replace' },
      },
    },
  },
  html = {},
  jedi_language_server = {},
  rust_analyzer = {},
  svelte = {
    settings = {
      svelte = {
        compilerWarnings = {
          ['a11y-missing-attribute'] = 'error',
        },
      },
      typescript = {
        preferences = { quoteStyle = 'auto' },
        inlayHints = {
          enumMemberValues = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          parameterNames = {
            enabled = 'none',
            suppressWhenArgumentMatchesName = true,
          },
          parameterTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          variableTypes = { enabled = true },
        },
      },
      html = {
        completions = { emmet = true },
      },
    },
  },
  tailwindcss = {
    filetypes = {
      'css',
      'html',
      'javascript',
      'javascriptreact',
      'less',
      'razor',
      'sass',
      'scss',
      'svelte',
      'typescript',
      'typescriptreact',
    },
    settings = {
      tailwindCSS = {
        experimental = {
          classRegex = { 'class:([a-zA-Z0-9_-]+)' },
        },
      },
    },
  },
  ts_ls = {
    settings = {
      typescript = {
        inlayHints = {
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayParameterNameHints = 'none',
          includeInlayVariableTypeHints = true,
        },
      },
    },
  },
}

M.mason_tools = {
  'stylua',
  'roslyn',
  'netcoredbg',
  'dcm',
}

M.formatters_by_ft = {
  lua = { 'stylua' },
}

M.treesitter_parsers = {
  'bash',
  'c',
  'c_sharp',
  'css',
  'diff',
  'html',
  'javascript',
  'json',
  'jsdoc',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'query',
  'svelte',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
}

return M
