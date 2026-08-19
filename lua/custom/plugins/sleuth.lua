vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- Files not to use vim-sleuth on. Instead fallback to the above configuration.
local excluded = {
  javascript = true,
  typescript = true,
}

-- Disable sleuth heuristics for excluded filetypes
for ft, _ in pairs(excluded) do
  vim.g['sleuth_' .. ft .. '_heuristics'] = 0
end

return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  lazy = false,
}
