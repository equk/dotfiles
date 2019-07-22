# dotfiles

    OS: Arch Linux
    Kernel: 5.2.1-arch1-1-ARCH
    Packages: 1265
    Window Manager: i3
    GTK Theme: Adapta-Eta [GTK2/3]
    GTK Font: Noto Sans 10 [GTK2/3]
    GTK Icons: Paper [GTK2/3]
    Shell: zsh
    Terminal: alacritty
    Terminal Font: xos4 Terminus
    CPU: Intel i5-2500K
    GPU: AMD ATI Radeon RX Vega 56
    GPU Driver: amdgpu

## screenshots

![](./screenshots/linux_desktop.png)

### i3bar conky

![](./screenshots/i3bar_conky.png)

### tk_logout

![](./screenshots/tk_logout_07062014.png)

## design

I designed the script to copy files as an alternative to having symlinks everywhere.

This allows me to control when I commit config changes to github (there may be times when testing settings etc).

It also means I don't have symlinks across different disk mount points.

install & backup features:

- [x] create folder structure if required
- [x] prompt before overwriting existing configuration
- [x] check for changes using diff
- [x] cli feedback for each config file
- [x] checks user is not root

## folder structure

    .
    ├── backup.sh
    ├── install.sh
    ├── configs/
    ├── lists/
    └── sys/

- `configs` contains config files from users `home` directory
- `lists` contains vscode extensions list
- `sys` contains files from linux system (eg: `/etc/`)

files in `sys` relate to specific hardware.

## install

    install.sh

example:

    equk :: linux dotfiles install
    ------------------------------

        git: https://github.com/equk
        web: https://equk.co.uk

    +++ installing equk dotfiles

    [+] Copying ./configs/.zsh/config.sh to /home/user/.zsh/config.sh
    [+] Copying ./configs/.zsh/lib/completion.zsh to /home/user/.zsh/lib/completion.zsh
    [+] Copying ./configs/.zsh/lib/tmux.zsh to /home/user/.zsh/lib/tmux.zsh
    [+] Copying ./configs/.zsh/lib/keyfix.zsh to /home/user/.zsh/lib/keyfix.zsh


## backup

    backup.sh

example:

    equk :: linux dotfiles backup
    -----------------------------

       git: https://github.com/equk
       web: https://equk.co.uk

    +++ copying dotfiles to /dotfiles/configs

    [+] copying base files
      [+] Copying /home/user/.bashrc
      [+] Copying /home/user/.vimrc
      [+] Copying /home/user/.zshrc
      [+] Copying /home/user/.tmux.conf
      [+] Copying /home/user/.compton.conf

# Contact

Website: https://equk.co.uk

Twitter: [@equilibriumuk](https://twitter.com/equilibriumuk)
