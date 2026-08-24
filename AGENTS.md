# Repository maintenance

This is a personal Neovim 0.12+ configuration. Keep startup deterministic and
prefer straightforward Lua modules over configuration frameworks.

## Boundaries

- `init.lua` remains a minimal entry point.
- Core editor behavior belongs in `lua/config/`.
- Every active plugin belongs to exactly one file under `lua/plugins/`.
- General language-server, formatter, Mason, and Tree-sitter declarations live
  in `lua/config/languages.lua`; integrations with substantial setup belong in
  `lua/plugins/lang/`.
- Machine-local overrides belong in the ignored `lua/config/local.lua` file.
- Do not add top-level side effects to plugin-spec modules; use `init`, `opts`,
  or `config` intentionally.
- Keep `lazy-lock.json` committed and remove entries for plugins no longer in
  the active spec.

## Verification

Run `make check` after configuration changes. It checks formatting, Lua
diagnostics, headless startup, and the Nix flake. Run `make format` to apply Lua
formatting.

When changing mappings, check for duplicate `(mode, lhs, scope)` definitions.
Mappings in different modes are not conflicts; global and buffer-local mappings
may be intentional overrides and should be documented.
