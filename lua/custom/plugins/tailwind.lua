return {
  -- Tailwind CSS Language Server
  {
    'neovim/nvim-lspconfig',
    -- Extend the main lspconfig opts only; do not run setup here
    opts = function(_, opts)
      opts = opts or {}
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, 'tailwindcss')

      opts.servers = opts.servers or {}
      opts.servers.tailwindcss = vim.tbl_deep_extend('force', opts.servers.tailwindcss or {}, {
        filetypes = {
          'html', 'css', 'scss', 'sass', 'less',
          'javascript', 'javascriptreact', 'typescript', 'typescriptreact',
          'svelte', 'astro', 'vue', 'templ',
        },
        init_options = {
          userLanguages = {
            svelte = 'html',
            astro = 'html',
            vue = 'html',
          },
        },
        settings = {
          tailwindCSS = {
            classRegex = {
              'class="([^"]*)"',
              'class:([a-zA-Z0-9_-]+)',
            },
            includeLanguages = {
              typescript = 'javascript',
              typescriptreact = 'javascript',
              svelte = 'html',
            },
            experimental = {
              classRegex = {
                { 'class:([a-zA-Z0-9_-]+)', 1 },
              },
            },
            validate = true,
          },
        },
      })
      return opts
    end,
  },
}
