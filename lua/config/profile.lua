local profile = {
  have_nerd_font = false,
  formatting = {
    disabled_filetypes = {
      c = true,
      cpp = true,
      razor = true,
    },
    excluded_path_fragments = {
      '/rosepoint/',
    },
  },
  java = {
    home_candidates = {
      '/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home',
      '/usr/local/opt/openjdk/libexec/openjdk.jdk/Contents/Home',
    },
  },
}

-- Machine-local settings can live in lua/config/local.lua. That file is
-- intentionally ignored so the shared configuration stays portable. Errors in
-- an existing override are allowed to surface instead of being silently hidden.
local local_path = vim.fs.joinpath(vim.fn.stdpath 'config' --[[@as string]], 'lua', 'config', 'local.lua')
if vim.uv.fs_stat(local_path) then
  local local_profile = require 'config.local'
  profile = vim.tbl_deep_extend('force', profile, local_profile)

  -- Deep extension merges numeric table keys. These values are lists, so a
  -- local profile should replace them as a unit, including with an empty list.
  if local_profile.formatting and local_profile.formatting.excluded_path_fragments then
    profile.formatting.excluded_path_fragments = local_profile.formatting.excluded_path_fragments
  end
  if local_profile.java and local_profile.java.home_candidates then
    profile.java.home_candidates = local_profile.java.home_candidates
  end
end

return profile
