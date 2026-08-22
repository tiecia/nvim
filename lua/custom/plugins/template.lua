return {
  'glepnir/template.nvim',
  cmd = { 'Template', 'TemProject' },
  config = function()
    require('template').setup {
      temp_dir = vim.fs.joinpath(vim.fn.stdpath 'config' --[[@as string]], 'templates'),
      -- author = 'Tie C',
      -- email = 'ty.cia@outlook.com',
      -- project = {
      --   ['cs'] = }
      --
      -- }
    }
  end,
}
