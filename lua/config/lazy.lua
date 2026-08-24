local lazypath = vim.fs.joinpath(vim.fn.stdpath 'data' --[[@as string]], 'lazy', 'lazy.nvim')

if not vim.uv.fs_stat(lazypath) then
  local repository = 'https://github.com/folke/lazy.nvim.git'
  local output = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', repository, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Unable to install lazy.nvim:\n' .. output)
  end
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  spec = require 'plugins',
  rocks = { enabled = false },
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
}
