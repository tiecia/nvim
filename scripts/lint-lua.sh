#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
lint_root="$(mktemp -d "${TMPDIR:-/tmp}/nvim-lua-lint.XXXXXX")"

cleanup() {
  rm -rf -- "$lint_root"
}
trap cleanup EXIT

lua-language-server \
  --check="$repo_root" \
  --checklevel=Warning \
  --check_format=pretty \
  --configpath="$repo_root/.luarc.json" \
  --logpath="$lint_root/log" \
  --metapath="$lint_root/meta"
