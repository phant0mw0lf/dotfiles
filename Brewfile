# Brewfile — `brew bundle` installs everything below. Language tool versions
# (opentofu, terragrunt, tflint, ruff, python, pwsh, ...) are owned by mise, see
# .config/mise/config.toml, and are intentionally NOT listed here.

tap "azure/azd", trusted: true
tap "databricks/tap"
tap "nikitabobko/tap"

# shell
brew "starship"
brew "zoxide"
brew "zsh-autosuggestions"
brew "zsh-syntax-highlighting"
brew "fzf"
brew "eza"
brew "bat"
brew "fd"
brew "ripgrep"
brew "git-delta"
brew "stow"
brew "tmux"
brew "yq"

# editor + git
brew "neovim"
brew "tree-sitter-cli" # parser builds for nvim-treesitter (main branch)
brew "lazygit"
brew "gh"

# linters and formatters used from nvim (not managed by mise)
brew "shellcheck"
brew "shfmt"
brew "hadolint"
brew "actionlint"
brew "zizmor"
brew "gitleaks"
brew "pre-commit"

# runtimes and package managers
brew "mise"
brew "uv"
brew "pipx"
brew "node"

# azure / data
brew "azure-cli"
brew "azcopy"
brew "pandoc"
brew "poppler"

# notebooks (molten-nvim)
brew "imagemagick"

# apps
cask "aerospace"
cask "alacritty"
cask "azure/azd/azd", trusted: true
cask "claude"
cask "claude-code@latest"
cask "dotnet-sdk"
cask "dotnet-sdk@9"
cask "font-meslo-lg-nerd-font"
cask "gitify"
cask "microsoft-azure-storage-explorer"
cask "mos"
cask "obsidian"
cask "powershell"
cask "rancher"
cask "spotify"
cask "utm"
cask "visual-studio-code" # kept for draw.io, mssql and dev containers only
cask "windows-app"

# python tools
uv "graphifyy"
uv "specify-cli", source: "git+https://github.com/github/spec-kit.git"
uv "yamllint"
uv "jupytext" # .ipynb <-> markdown for molten

# node tools
npm "defuddle"
