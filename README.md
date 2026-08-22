# Neovim configuration

My personal Neovim configuration, originally based on
[kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). It targets
Neovim 0.12 or newer and uses lazy.nvim for plugins, Mason for external editor
tools, and the native `vim.lsp.config` API for language servers.

## Requirements

The baseline tools are:

- Neovim 0.12 or newer
- `git`, `make`, `unzip`, and a C compiler
- `ripgrep`, `fd`, and the Tree-sitter CLI
- a clipboard provider appropriate for the operating system
- a Nerd Font if `vim.g.have_nerd_font` is enabled in `init.lua`

Language-specific features also need their normal runtimes and build tools. In
particular, this configuration supports .NET/C# and Razor, Java, Rust,
TypeScript/Svelte, and Flutter/Dart. Install the .NET 10 SDK (or newer), a JDK,
Cargo, Node.js/npm, and the Flutter SDK for the languages you use. Mason installs the
corresponding language servers, formatters, and `netcoredbg` where possible.

## Install

Back up an existing Neovim configuration, then clone this repository:

```sh
git clone https://github.com/tiecia/nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
nvim
```

On the first launch, lazy.nvim installs plugins and Mason installs the tools
listed in `init.lua`. Run these commands afterward to inspect the result:

```vim
:Lazy
:Mason
:checkhealth
```

`lazy-lock.json` is committed so a checkout uses the same tested plugin
revisions. Run `:Lazy restore` if a local plugin tree drifts from the lockfile.

## Nix

The flake supplies the baseline tools and can run this configuration in an
isolated Neovim app name:

```sh
nix run github:tiecia/nvim
```

It also exports `homeModules.default`. A Home Manager flake can import it with:

```nix
{
  inputs.nvim.url = "github:tiecia/nvim";

  outputs = { home-manager, nvim, ... }: {
    # Add nvim.homeModules.default to the modules for your home configuration.
  };
}
```

## Maintenance

- Update plugins with `:Lazy update`, review the changes, and commit the updated
  `lazy-lock.json`.
- Update Mason-managed tools with `:MasonUpdate` and `:MasonToolsUpdate`.
- Update parsers with `:TSUpdate`.
- Update Nix inputs with `nix flake update`.
- Check Lua formatting with `stylua --check init.lua lua`.
- Run `:checkhealth` after Neovim or toolchain upgrades.

The main plugin and editor configuration lives in `init.lua`. Feature-specific
plugins live under `lua/custom/plugins/`, reusable modules under
`lua/kickstart/`, and new-file templates under `templates/`.
