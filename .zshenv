# ~/.zshenv — sourced by every zsh (login, interactive, and `zsh -c`), so tools
# launched from nvim, dap, neotest or scripts see the same PATH as the terminal.

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# uv / pipx / user binaries
export PATH="$HOME/.local/bin:$PATH"

# mise shims for non-interactive shells (interactive shells use `mise activate` in .zshrc)
export PATH="$HOME/.local/share/mise/shims:$PATH"

# Homebrew
export HOMEBREW_NO_ENV_HINTS=1
