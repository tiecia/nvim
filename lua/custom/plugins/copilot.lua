function buildStep()
  if vim.fn.has 'mac' == 1 or vim.fn.has 'unix' == 1 then
    vim.fn.system 'make tiktoken'
  end
end

return {
  -- {
  --   'CopilotC-Nvim/CopilotChat.nvim',
  --   dependencies = {
  --     { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
  --     { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
  --   },
  --   build = buildStep(), -- Only on MacOS or Linux
  --   opts = {
  --     -- See Configuration section for options
  --   },
  --   config = function()
  --     local copilot = require 'CopilotChat'
  --     vim.keymap.set('n', '<leader>cc', function()
  --       copilot.toggle()
  --     end, { desc = 'Copilot: Toggle Chat' })
  --   end,
  --   -- See Commands section for default commands if you want to lazy load on them
  -- },
}
