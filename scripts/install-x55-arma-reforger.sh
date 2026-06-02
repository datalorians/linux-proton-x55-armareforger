#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mkdir -p "$HOME/.local/bin"

install -m 0755 \
  "$repo_root/bin/x55-arma-reforger-virtual-gamepad" \
  "$repo_root/bin/x55-arma-reforger-stop-virtual-gamepad" \
  "$HOME/.local/bin/"

echo "Installed X-55 Arma Reforger helper commands into $HOME/.local/bin"
