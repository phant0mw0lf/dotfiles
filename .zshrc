# ~/.zshrc — interactive zsh. PATH for every shell (incl. non-interactive) lives in ~/.zshenv.

# ---------- editor ----------
export EDITOR=nvim
export VISUAL=nvim
export GIT_EDITOR=nvim
export MANPAGER='nvim +Man!'
alias vi='nvim'
alias vim='nvim'

# ---------- history ----------
HISTFILE=$HOME/.zhistory
HISTSIZE=100000
SAVEHIST=100000
setopt share_history          # share between sessions
setopt inc_append_history     # write immediately, not on exit
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_space      # commands starting with a space are not recorded
setopt hist_reduce_blanks
setopt hist_verify

# ---------- completion ----------
autoload -Uz compinit
compinit -C -d "${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # case-insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# arrow keys search history by prefix
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ---------- tools ----------
eval "$(mise activate zsh)"     # opentofu, terragrunt, tflint, ruff, python, pwsh, ... (see ~/.config/mise/config.toml)
eval "$(zoxide init zsh)"
source <(fzf --zsh)
eval "$(starship init zsh)"

# ---------- aliases ----------
alias ls='eza --icons=always'
alias ll='eza -la --icons=always --git --group-directories-first'
alias lt='eza --tree --level=2 --icons=always'
alias cd='z'                   # zoxide
alias lg='lazygit'
alias tofu-fmt='tofu fmt -recursive'

# ---------- 1Password SSH agent ----------
export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
[[ -d "$HOME/.rd/bin" ]] && export PATH="$HOME/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# ---------- zsh plugins (syntax highlighting must be sourced last) ----------
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ---------- machine-specific overrides (not tracked) ----------
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
