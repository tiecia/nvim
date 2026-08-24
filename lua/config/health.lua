local M = {}

local function check_version()
  local version = tostring(vim.version())
  if vim.version.ge(vim.version(), '0.12.0') then
    vim.health.ok('Neovim version: ' .. version)
  else
    vim.health.error('Neovim 0.12 or newer is required; found ' .. version)
  end
end

local function check_executables()
  for _, executable in ipairs { 'git', 'make', 'unzip', 'rg', 'fd', 'tree-sitter' } do
    if vim.fn.executable(executable) == 1 then
      vim.health.ok('Found executable: ' .. executable)
    else
      vim.health.warn('Missing executable: ' .. executable)
    end
  end
end

function M.check()
  vim.health.start 'tiecia.nvim'
  vim.health.info('System information: ' .. vim.inspect(vim.uv.os_uname()))
  check_version()
  check_executables()
end

return M
