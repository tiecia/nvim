function TemplatePath()
  if vim.fn.has 'macunix' then
    return '~/.config/nvim/templates'
  else
    return '%LOCALAPPDATA%/nvim/templates'
  end
end

return {
  'glepnir/template.nvim',
  cmd = { 'Template', 'TemProject' },
  config = function()
    require('template').setup {
      temp_dir = TemplatePath(),
      -- author = 'Tie C',
      -- email = 'ty.cia@outlook.com',
      -- project = {
      --   ['cs'] = }
      --
      -- }
    }
  end,
}
