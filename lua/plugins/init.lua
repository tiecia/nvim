local plugins = {}

for _, module in ipairs {
  'plugins.completion',
  'plugins.editor',
  'plugins.formatting',
  'plugins.git',
  'plugins.lsp',
  'plugins.navigation',
  'plugins.treesitter',
  'plugins.ui',
  'plugins.lang.dotnet',
  'plugins.lang.flutter',
  'plugins.lang.java',
} do
  vim.list_extend(plugins, require(module))
end

return plugins
