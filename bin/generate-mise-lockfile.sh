#!/bin/bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
mise_dir="$repo_root/dot_config/mise"
lockfile="$mise_dir/mise.lock"
sidecar_dir="$mise_dir/dot_mise"

tmp_config_dir="$(mktemp -d)"
cleanup() { rm -rf "$tmp_config_dir"; }
trap cleanup EXIT

mkdir -p "$tmp_config_dir/conf.d"
cp "$mise_dir/config.toml" "$tmp_config_dir/"
cp "$mise_dir"/conf.d/*.toml "$tmp_config_dir/conf.d/"

export MISE_CONFIG_DIR="$tmp_config_dir"
export MISE_LOCKED=0
export MISE_YES=1

cd "$tmp_config_dir"

mise trust --all >/dev/null 2>&1 || true

echo "Resolving tools from:"
for f in "$tmp_config_dir"/conf.d/*.toml; do
  echo "  - conf.d/$(basename "$f")"
done
echo

mise lock -g -p linux-arm64,macos-arm64

declared_tools="$(mise config ls 2>/dev/null | awk -F'  +' '/conf\.d/ {print $2}' | tr ',' '\n' | sed -E 's/^ +| +$//g' | sort -u)"
locked_tools="$(grep -oE '^\[\[tools\."?[^]"]+"?\]\]' "$tmp_config_dir/mise.lock" | sed -E 's/^\[\[tools\."?//; s/"?\]\]$//' | sort -u)"
dropped="$(comm -23 <(echo "$declared_tools") <(echo "$locked_tools"))"

cp "$tmp_config_dir/mise.lock" "$lockfile"

rm -rf "$sidecar_dir"
if [[ -d "$tmp_config_dir/.mise" ]]; then
  mkdir -p "$sidecar_dir"
  cp -R "$tmp_config_dir/.mise/." "$sidecar_dir/"
fi

echo
echo "Wrote $lockfile"
if [[ -d "$sidecar_dir" ]]; then
  echo "Wrote $sidecar_dir"
fi

if [[ -n "$dropped" ]]; then
  echo
  echo "WARNING: these tools are declared in conf.d but could not be resolved this run (likely missing npm/node or network access) and are missing from the lockfile:"
  echo "$dropped" | sed 's/^/  /'
  echo "Review before committing. You may need to rerun with the missing dependency available."
fi
