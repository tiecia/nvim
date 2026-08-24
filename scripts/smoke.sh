#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
smoke_root="$(mktemp -d "${TMPDIR:-/tmp}/nvim-config-smoke.XXXXXX")"

cleanup() {
  rm -rf -- "$smoke_root"
}
trap cleanup EXIT

mkdir -p "$smoke_root/config" "$smoke_root/state" "$smoke_root/cache"
ln -s "$repo_root" "$smoke_root/config/nvim"

XDG_CONFIG_HOME="$smoke_root/config" \
XDG_STATE_HOME="$smoke_root/state" \
XDG_CACHE_HOME="$smoke_root/cache" \
  nvim --headless \
    "$repo_root/README.md" \
    '+lua assert(vim.g.colors_name == "darkplus", "colorscheme did not load")' \
    '+lua assert(vim.bo.filetype == "markdown", "filetype detection did not run")' \
    '+qa'
