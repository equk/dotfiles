# equk :: dotfiles

Configuration for Arch Linux with custom scripts allowing install & backup.

More Info: [Automated dotfiles - equk's blog](https://equk.co.uk/2019/07/24/automated-dotfiles)

![](./screenshots/linux_desktop.png)

    OS: Arch Linux
    Kernel: 5.12.15
    Packages: 1283
    Window Manager: i3
    GTK Theme: Adapta-Eta [GTK2/3]
    GTK Font: Open Sans 10 [GTK2/3]
    GTK Icons: Vimix-Black-dark [GTK2/3]
    Shell: zsh
    Terminal: alacritty
    Terminal Font: Terminus
    GPU: AMD ATI Radeon RX Vega 56
    GPU Driver: amdgpu
    Disk Encryption: AES-256 (512bit aes-xts-plain64)
    (root fs uses LUKS + dm-crypt)

## Installation

    install.sh

### vscode

to install vscode extensions run

    xargs -n 1 -a lists/vscode_extensions.txt code --install-extension

### neovim

neovim config should install plugins automatically using vim-plug

requirements:

- fzf
- ripgrep
- rust-analyzer

---

### vim

install Vundle and plugins

    mkdir -p ~/.vim/bundle
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall

more info on plugins can be found in `lists/vim_plugins.md`

### vim colorscheme

To install the `jellybeans` vim colorscheme

    mkdir -p ~/.vim/colors
    cd ~/.vim/colors
    curl -O https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim

---

## Screenshots

![](./screenshots/linux_desktop.png)

### i3bar conky

![](./screenshots/i3bar_conky.png)

### tk_logout

![](./screenshots/tk_logout_07062014.png)

---

# Contact

Website: https://equk.co.uk

Twitter: [@equilibriumuk](https://twitter.com/equilibriumuk)
