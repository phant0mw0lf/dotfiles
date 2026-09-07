# dotfiles

macOS dotfiles, managed with [GNU Stow](https://www.gnu.org/software/stow/). Neovim is the only editor;
everything else (Alacritty, tmux, zsh, starship, AeroSpace, git) is set up around it. Theme is
Catppuccin Mocha everywhere.

## Install

```bash
git clone git@github.com:phant0mw0lf/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

`install.sh` is idempotent. It installs Homebrew packages from `Brewfile`, links the dotfiles with
`stow --no-folding`, installs tmux plugins, mise tools, treesitter parsers, mason packages and the
python host venv for nvim.

### Stow

Always link with `--no-folding`. Without it stow symlinks whole directories such as `~/.config`
into the repo, and every app then writes its state (gh tokens, 1Password, NuGet, ...) into the
repository.

```bash
cd ~/dotfiles
stow --restow --no-folding .   # after adding or removing files
stow -D .                      # unlink everything
```

`.stow-local-ignore` keeps repo-only files (README, Brewfile, install.sh, .claude/c4a8-azure.hash) out
of `~`. App state directories are git-ignored in `.gitignore`.

## What is where

| Path | Tool | Notes |
| --- | --- | --- |
| `.config/nvim/` | Neovim 0.12 | lazy.nvim, blink.cmp, snacks.nvim, treesitter (main), native `vim.lsp.config` |
| `.config/mise/config.toml` | mise | opentofu, terragrunt, tflint, ruff, python, pwsh, jq, ... |
| `.zshrc`, `.zshenv` | zsh | starship, zoxide, fzf, mise; `.zshenv` carries PATH for non-interactive shells |
| `.gitconfig`, `.gitconfig-work` | git | SSH signing, work identity per org, delta pager, nvimdiff, aliases |
| `.tmux.conf` | tmux | prefix `C-Space`, vim navigation, catppuccin, sessionx, resurrect |
| `.config/alacritty/` | Alacritty | MesloLGS Nerd Font Mono (from the Brewfile) |
| `.config/aerospace/` | AeroSpace | tiling WM, `alt` + hjkl / workspace letters |
| `.config/karabiner/` | Karabiner | Caps Lock → Escape, left Alt as AeroSpace modifier |
| `.config/starship.toml` | starship | prompt incl. Claude Code session info |
| `.claude/` | Claude Code | `settings.json`, `statusline.sh`, global `CLAUDE.md` |
| `Brewfile` | Homebrew | formulae, casks, uv tools |

## Neovim

Leader is `Space`, `jk` leaves insert mode. `<leader>fk` lists every keymap; which-key shows groups.

### Language support

| Language | LSP | Format | Lint / test / debug |
| --- | --- | --- | --- |
| OpenTofu / HCL | tofu_ls | `tofu fmt`, `terragrunt hcl fmt` | tflint |
| PowerShell | powershell_es | LSP (OTBS) | PSScriptAnalyzer via LSP |
| Python | basedpyright + ruff | ruff (format + imports) | ruff, pytest (neotest), debugpy |
| C# | roslyn | csharpier | neotest-dotnet, netcoredbg |
| YAML | yamlls + schemastore | prettier | yamllint; workflows also actionlint + zizmor |
| JSON / TOML | jsonls + schemastore, taplo | prettier, taplo | |
| Bash / zsh | bashls | shfmt | shellcheck via bashls |
| Docker | dockerls | | hadolint |
| Markdown | marksman | prettier | markdownlint-cli2, render-markdown |
| Lua | lua_ls + lazydev | stylua | |
| Web (ts/tsx/svelte/html/css) | ts_ls, svelte, html, cssls, tailwind, emmet, graphql, prisma | prettier | eslint_d |
| Bicep, XML | bicep, lemminx | | |

Language servers come from mason (`:Mason`), ruff and tflint from mise, shell linters from brew.

### Keymaps

| Keys | Action |
| --- | --- |
| `<C-e>` / `<leader>ee` / `<leader>ef` | toggle explorer / reveal file (`a` add, `r` rename, `d` delete, `c` copy, `m` move, `p` paste) |
| `-` | edit directory as buffer (oil) |
| `<leader>ff` `fr` `fs` `fc` `fb` `fg` `ft` | files, recent, grep, word under cursor, buffers, git files, todos |
| `gd` `gR` `gi` `gt` `K` | definitions, references, implementations, type defs, hover |
| `<leader>ca` `rn` `cs` `cf` | code action, rename, symbols, format |
| `<leader>d` `D` `[d` `]d` `xx` | line diagnostics, buffer diagnostics, prev/next, Trouble |
| `<C-n>` `<C-Up>` `<C-Down>` | multi-cursor: next match, cursor above/below |
| `s` / `S` / `<C-space>` | flash jump / treesitter selection |
| `gc` `gcc` | comment (native) |
| `<leader>lg` `gd` `gh` `hb` `hs` `hr` | lazygit, diffview, file history, blame, stage hunk, reset hunk |
| `<F5>` `<F10>` `<F11>` `<leader>bb` `bu` | debug continue, step over, step into, breakpoint, dap ui |
| `<leader>nr` `nf` `ns` `no` `nd` | test nearest, file, summary, output, debug |
| `<leader>ac` `as` `ab` `aa` `ad` | Claude Code toggle, send selection, add buffer, accept/deny diff |
| `<leader>mi` `ml` `me` `mo` | molten init kernel, eval line, eval operator/selection, output |
| `<leader>wr` `ws` | restore / save session |
| `<leader>sv` `sh` `sm` `to` `tn` `tp` | splits and tabs |
| `<leader>u*` | toggles: format on save `uf`, wrap `uw`, spell `us`, diagnostics `ud`, inlay hints `uh` |
| `<C-h/j/k/l>` | move between nvim splits and tmux panes |

### Notebooks

`.ipynb` files open as markdown (jupytext) and are written back on save. `<leader>mi` picks a
kernel; register the project's venv once with
`uv run python -m ipykernel install --user --name <project>`. Alacritty has no image protocol, so
plots are not shown inline.

## tmux

Prefix is `C-Space`. `/` and `-` split, `h j k l` move, `o` opens sessionx, `C` opens Claude Code in
a popup for the current pane path, `z` zooms. Plugins are installed by tpm (`prefix + I`).

## git identity

Repos under the `c4a8`, `c4a8-*` and `azurefoundation-*` GitHub orgs get the work e-mail from
`.gitconfig-work` via `includeIf`. Everything else uses the personal identity. Commits are signed
with the 1Password SSH agent.
