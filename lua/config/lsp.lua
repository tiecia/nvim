local M = {}

local attach_group = vim.api.nvim_create_augroup('tiecia-lsp-attach', { clear = true })
local highlight_group = vim.api.nvim_create_augroup('tiecia-lsp-highlight', { clear = true })
local detach_group = vim.api.nvim_create_augroup('tiecia-lsp-detach', { clear = true })

function M.setup_attach()
  vim.api.nvim_create_autocmd('LspAttach', {
    group = attach_group,
    callback = function(event)
      local function map(keys, func, desc, mode)
        vim.keymap.set(mode or 'n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      local telescope = require 'telescope.builtin'
      map('gd', telescope.lsp_definitions, '[G]oto [D]efinition')
      map('gr', telescope.lsp_references, '[G]oto [R]eferences')
      map('gI', telescope.lsp_implementations, '[G]oto [I]mplementation')
      map('<leader>D', telescope.lsp_type_definitions, 'Type [D]efinition')
      map('<leader>ds', telescope.lsp_document_symbols, '[D]ocument [S]ymbols')
      map('<leader>ws', telescope.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
      map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
      map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
      map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_group,
          callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_group,
          callback = vim.lsp.buf.clear_references,
        })
        vim.api.nvim_create_autocmd('LspDetach', {
          buffer = event.buf,
          group = detach_group,
          once = true,
          callback = function(detach_event)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = highlight_group, buffer = detach_event.buf }
          end,
        })
      end

      if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
        map('<leader>th', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
        end, '[T]oggle Inlay [H]ints')
      end
    end,
  })
end

function M.configure_diagnostics()
  vim.diagnostic.config {
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs = vim.g.have_nerd_font and {
      text = {
        [vim.diagnostic.severity.ERROR] = '󰅚 ',
        [vim.diagnostic.severity.WARN] = '󰀪 ',
        [vim.diagnostic.severity.INFO] = '󰋽 ',
        [vim.diagnostic.severity.HINT] = '󰌶 ',
      },
    } or {},
    virtual_text = {
      source = 'if_many',
      spacing = 2,
      format = function(diagnostic)
        return diagnostic.message
      end,
    },
  }
end

function M.capabilities()
  return vim.tbl_deep_extend('force', vim.lsp.protocol.make_client_capabilities(), require('cmp_nvim_lsp').default_capabilities())
end

return M
