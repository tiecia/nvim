return {
  'JoosepAlviste/nvim-ts-context-commentstring',
  event = 'VeryLazy',
  config = function()
    require('ts_context_commentstring').setup {
      enable_autocmd = false,
    }

    -- Calculate the comment style at the cursor when Neovim's native `gc`
    -- operator requests it. This handles Svelte's script/style/template regions
    -- without continuously mutating 'commentstring' on CursorHold.
    local get_option = vim.filetype.get_option
    vim.filetype.get_option = function(filetype, option)
      if option == 'commentstring' then
        return require('ts_context_commentstring.internal').calculate_commentstring() or get_option(filetype, option)
      end
      return get_option(filetype, option)
    end
  end,
}
