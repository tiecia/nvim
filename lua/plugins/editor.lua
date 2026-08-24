return {
  {
    'okuuva/auto-save.nvim',
    version = '^1.0.0',
    cmd = 'ASToggle',
    event = { 'InsertLeave', 'TextChanged' },
    opts = {
      condition = function(bufnr)
        local name = vim.api.nvim_buf_get_name(bufnr)
        return name ~= '' and not name:match '^oil-'
      end,
    },
  },
  {
    'tpope/vim-sleuth',
    lazy = false,
    init = function()
      vim.opt.shiftwidth = 4
      vim.opt.tabstop = 4
      vim.g.sleuth_javascript_heuristics = 0
      vim.g.sleuth_typescript_heuristics = 0
    end,
  },
}
