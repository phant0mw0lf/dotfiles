#!/usr/bin/env bash
# Bootstrap a new Mac from this repo. Idempotent: safe to re-run.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log() { printf '\n\033[1;32m==> %s\033[0m\n' "$*"; }

log "Homebrew"
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
brew bundle --file="$DOTFILES/Brewfile"

log "Real directories that must exist before stow (prevents folding whole trees into the repo)"
mkdir -p "$HOME/.config" "$HOME/.ssh" "$HOME/.claude" "$HOME/.local/bin"
chmod 700 "$HOME/.ssh"

log "Stow (per-file symlinks, never fold directories)"
cd "$DOTFILES"
stow --restow --no-folding --verbose=1 .

log "tmux plugin manager"
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi
"$HOME/.tmux/plugins/tpm/bin/install_plugins" || true

log "mise tools"
mise install --yes

log "Python host for nvim remote plugins (molten)"
if [ ! -x "$HOME/.local/share/nvim/venv/bin/python" ]; then
  uv venv "$HOME/.local/share/nvim/venv"
fi
uv pip install --quiet --python "$HOME/.local/share/nvim/venv/bin/python" pynvim jupyter_client ipykernel

log "German spell files (spelllang=en,de)"
mkdir -p "$HOME/.local/share/nvim/site/spell"
for f in de.utf-8.spl de.utf-8.sug; do
  [ -f "$HOME/.local/share/nvim/site/spell/$f" ] || curl -fsSL -o "$HOME/.local/share/nvim/site/spell/$f" "https://ftp.nluug.nl/pub/vim/runtime/spell/$f"
done

log "Neovim plugins, treesitter parsers and mason packages"
nvim --headless "+Lazy! restore" +qa
nvim --headless "+lua require('nvim-treesitter').install(require('phant0mw0lf.treesitter_parsers')):wait(900000)" +qa
nvim --headless "+MasonToolsInstallSync" +qa
nvim --headless "+UpdateRemotePlugins" +qa

log "Done. Open a new shell (or run: exec zsh)."
