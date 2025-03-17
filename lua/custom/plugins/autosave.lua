return {
  'okuuva/auto-save.nvim',
  version = '^1.0.0', -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
  cmd = 'ASToggle', -- optional for lazy loading on command
  event = { 'InsertLeave', 'TextChanged' }, -- optional for lazy loading on trigger events
  opts = {
    -- your config goes here
    -- or just leave it empty :)
    condition = function(buf)
      -- Exclude oil.nvim buffers
      if vim.api.nvim_buf_get_name(buf) == '' or vim.api.nvim_buf_get_name(buf):match '^oil-' then
        return false
      end
      return true
    end,
  },
}
