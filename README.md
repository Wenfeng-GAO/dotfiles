# dotfiles

Personal dotfiles managed by [chezmoi](https://www.chezmoi.io/).

## Included

- Ghostty configuration
- Yazi configuration and Catppuccin flavors
- `cdxb` and sanitized `cld` helper scripts
- Public zsh modules for aliases, Atuin, Zoxide, Yazi shell wrapper, and history suggestions
- Atuin config
- Alfred `Proxy Clipboard` workflow

## Bootstrap

```sh
chezmoi init Wenfeng-GAO/dotfiles
chezmoi diff
chezmoi apply
```

## Private Local Files

The `cld` helper reads credentials from `~/.config/cld/env`.
Create it locally from the example file and keep it out of git:

```sh
cp ~/.config/cld/env.example ~/.config/cld/env
chmod 600 ~/.config/cld/env
```

Local-only zsh secrets can live in `~/.config/zsh/private.env`.
