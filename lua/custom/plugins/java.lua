return {
  'nvim-java/nvim-java',
  config = function()
    if not vim.env.JAVA_HOME or not vim.uv.fs_stat(vim.fs.joinpath(vim.env.JAVA_HOME, 'bin', 'java')) then
      for _, candidate in ipairs {
        '/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home',
        '/usr/local/opt/openjdk/libexec/openjdk.jdk/Contents/Home',
      } do
        if vim.uv.fs_stat(vim.fs.joinpath(candidate, 'bin', 'java')) then
          vim.env.JAVA_HOME = candidate
          break
        end
      end
    end

    require('java').setup()
    vim.lsp.enable 'jdtls'
  end,
}
