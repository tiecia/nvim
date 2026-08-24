# Neovim configuration

Personal Neovim configuration targeting Neovim 0.12 or newer. It uses
[lazy.nvim](https://github.com/folke/lazy.nvim) for plugins, Mason for editor
tooling, the native `vim.lsp.config` API, and Nix for a reproducible development
and packaged environment.

## Requirements

The baseline tools are:

- Neovim 0.12 or newer
- `git`, `make`, `unzip`, and a C compiler
- `ripgrep`, `fd`, and the Tree-sitter CLI
- A clipboard provider appropriate for the operating system

Language integrations require their normal runtimes. Install the .NET SDK, a
JDK, Cargo, Node.js/npm, and Flutter for the languages you use. Mason installs
the configured language servers, formatters, and debug adapters.

## Install

Back up an existing configuration and clone this repository:

```sh
git clone https://github.com/tiecia/nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
nvim
```

On first launch, lazy.nvim installs the plugins pinned in `lazy-lock.json`.
Inspect the installation with `:Lazy`, `:Mason`, and `:checkhealth config`.

## Architecture

```text
init.lua                 Minimal entry point
lua/config/              Core editor behavior and shared configuration data
lua/plugins/             Active plugin specifications, grouped by responsibility
lua/plugins/lang/        Integrations requiring language-specific orchestration
templates/               New-file templates
scripts/                 Reproducible diagnostics and startup checks
```

`lua/config/languages.lua` is the shared inventory for general LSP servers,
Mason tools, formatters, and Tree-sitter parsers. More involved integrations,
such as Roslyn, Java, Flutter, DAP, and .NET testing, have dedicated modules
under `lua/plugins/lang/`.

Neovim 0.12 handles injected-language comment strings natively, including
Svelte script and style regions, so the configuration does not patch Neovim's
filetype APIs.

## Local profile

Personal defaults and named machine-specific policy live in
`lua/config/profile.lua`. To override them on one machine, create the ignored
`lua/config/local.lua` module. Its values are deeply merged with the defaults:

```lua
return {
  have_nerd_font = true,
  formatting = {
    excluded_path_fragments = {},
  },
  java = {
    home_candidates = { '/path/to/jdk' },
  },
}
```

## Verification and maintenance

The standard commands are:

```sh
make format        # Format all Lua through the pinned Nix environment
make check         # Formatting, diagnostics, startup smoke test, and flake checks
make smoke         # Start the configuration headlessly
make health        # Run this configuration's health check
make update        # Update plugins and Nix inputs
```

`lazy-lock.json` is committed so checkouts use tested plugin revisions. Review
plugin changes before committing an updated lockfile. CI runs the same local
formatting, diagnostic, startup, and Nix checks on pushes and pull requests.

## Nix

The flake supplies baseline command-line tools and can run the configuration
under an isolated Neovim app name:

```sh
nix run github:tiecia/nvim
```

It also exports `homeModules.default` for Home Manager configurations.
