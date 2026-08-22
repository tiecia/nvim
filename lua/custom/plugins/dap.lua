return {
  'mfussenegger/nvim-dap',
  config = function()
    local dap = require 'dap'
    local netcoredbg = vim.fn.exepath 'netcoredbg'
    if netcoredbg == '' then
      netcoredbg = vim.fs.joinpath(vim.fn.stdpath 'data' --[[@as string]], 'mason', 'bin', 'netcoredbg')
    end

    dap.adapters.netcoredbg = {
      type = 'executable',
      command = netcoredbg,
      args = { '--interpreter=vscode' },
    }

    dap.configurations.cs = {
      {
        type = 'netcoredbg',
        name = 'launch - netcoredbg',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end,
      },
    }
  end,
}
