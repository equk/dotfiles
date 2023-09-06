# equk :: dotfiles

Configuration for Arch Linux with custom scripts allowing install & backup.

More Info: [Automated dotfiles - equk's blog](https://equk.co.uk/2019/07/24/automated-dotfiles)

![](./screenshots/hyprland_desktop.jpg)

| | |
|---|---|
| OS | [Arch Linux](https://archlinux.org) |
| Window Manager | [Hyprland](https://hyprland.org/) |
| Terminal | [Alacritty](https://alacritty.org/) |
| Shell | [zsh](https://www.zsh.org/) |
| Editor | [neovim](https://github.com/neovim/neovim) |
| Editor2 | [vscode](https://github.com/microsoft/vscode) |
| Launcher | [wofi](https://github.com/uncomfyhalomacro/wofi) |
| File Manager | [thunar](https://docs.xfce.org/xfce/thunar/start) |
| Media Player | [mpv](https://mpv.io/) |
| Web Browser | [firefox](https://www.mozilla.org/firefox/) |

## Installation

    install.sh

### vscode

to install vscode extensions run

    xargs -n 1 -a lists/vscode_extensions.txt code --install-extension

### neovim

neovim config should install plugins automatically using packer

requirements:

- ripgrep
- rust-analyzer
- gopls
- lua-language-server (sumneko)
- tsserver

### firefox

firefox profiles are managed using [ffox_profile_tools](https://github.com/equk/ffox_profile_tools)

> firefox profiles with security & privacy settings already preset

---

# Contact

Website: https://equk.co.uk

Mastodon: [@equilibriumuk@hachyderm.io](https://hachyderm.io/@equilibriumuk)
