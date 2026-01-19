return {
  -- Syntax highlighting for Svelte single-file components
  {
    'evanleck/vim-svelte',
    ft = { 'svelte' },
  },

  -- Treesitter parser support for Svelte (better syntax/indent/highlights)
  -- Context-aware commenting for Svelte (template/script/style)
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    event = 'VeryLazy',
    config = function()
      -- Use standalone setup and skip deprecated Treesitter module integration
      vim.g.skip_ts_context_commentstring_module = true
      -- Enable Treesitter-driven commentstring updates
      require('ts_context_commentstring').setup {}

      -- Integrate with Comment.nvim if available
      local ok, comment = pcall(require, 'Comment')
      if ok then
        comment.setup {
          pre_hook = function(ctx)
            local status, tscc = pcall(require, 'ts_context_commentstring.integrations.comment_nvim')
            if status then
              return tscc.create_pre_hook()(ctx)
            end
          end,
        }
      end

      -- Fallback: ensure a sane default for Svelte buffers
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'svelte',
        callback = function(ev)
          -- Default to HTML-style comments in the template region
          vim.bo[ev.buf].commentstring = '<!-- %s -->'
        end,
      })
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      opts = opts or {}
      opts.ensure_installed = opts.ensure_installed or {}
      if type(opts.ensure_installed) == 'table' then
        table.insert(opts.ensure_installed, 'svelte')
        table.insert(opts.ensure_installed, 'typescript')
        table.insert(opts.ensure_installed, 'css')
        table.insert(opts.ensure_installed, 'html')
        table.insert(opts.ensure_installed, 'json')
      end
      return opts
    end,
  },

  -- Svelte Language Server configuration (VS Code-like features)
  {
    'neovim/nvim-lspconfig',
    dependencies = {},
    -- Extend the main lspconfig opts only; do not run setup here
    opts = function(_, opts)
      opts = opts or {}
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { 'svelte', 'tailwindcss', 'ts_ls' })

      opts.servers = opts.servers or {}
      opts.servers.svelte = vim.tbl_deep_extend('force', opts.servers.svelte or {}, {
        settings = {
          svelte = {
            plugin = {
              svelte = {
                compilerWarnings = {
                  ['a11y-missing-attribute'] = 'warning',
                },
              },
              typescript = {
                preferences = {
                  quoteStyle = 'auto',
                },
              },
              css = {
                emmetCompletions = true,
              },
            },
            enableTsPlugin = true,
          },
        },
      })

      opts.servers.ts_ls = vim.tbl_deep_extend('force', opts.servers.ts_ls or {}, {
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = 'none',
              includeInlayVariableTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
            },
          },
        },
      })

      return opts
    end,
  },
}
