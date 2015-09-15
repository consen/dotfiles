#!/usr/bin/env bash

#====================================================
# Install dotfiles, create symbol links:
# ~/.vimrc -> from/to/dotfiles/vim/vimrc
# ~/.tmux.conf -> from/to/dotfiles/tmux/tmux.conf
# ~/.gitconfig -> from/to/dotfiles/git/gitconfig
# and install some essential tools.
#====================================================

set -e

color_red="\e[0;31m"
color_green="\e[0;32m"
color_yellow="\e[0;33m"
color_blue="\e[0;34m"
color_end="\e[0m"

echo_ok() {
    echo -e "  [ ${color_green}OK${color_end} ] $1"
}

echo_error() {
    echo -e "  [ ${color_red}ERROR${color_end} ] $1"
}

echo_user() {
    echo -ne "  [ ${color_yellow}?${color_end} ] $1"
}

echo_info() {
    echo -e "  [ ${color_blue}...${color_end} ] $1"
}

command_exists() {
    hash "$1" 2>/dev/null
}

install_command() {
    if command_exists yum; then
        sudo yum install $@
        echo_ok "$@ installed."
    else
        echo_error "Install $@ yourself and retry."
        exit 1
    fi
}

for tool in git vim tmux; do
    if ! command_exists $tool; then
        install_command $tool
    fi
done

backup_dir="$HOME/.dotfiles_backup"
dotfiles="vimrc tmux.conf gitconfig"

# Backup old dotfiles
echo_info "Creating $backup_dir for backup of any existing dotfiles in $HOME ..."
mkdir -p "$backup_dir"

for file in $dotfiles; do
    if [[ -f "$HOME/.$file" ]]; then
    	mv "$HOME/.$file" "$backup_dir"
    	echo_ok "Moving old .$file from $HOME/ to $backup_dir"
    fi
done

echo

# Get directory of file install.sh
# So you can run install.sh in dotfiles directory -- ./install.sh
# or any directory out of dotfiles -- ./from/to/dotfiles/install.sh
script_dir="$( cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo_info "Installing dotfiles ..."

ln -s "$script_dir/vim/vimrc" "$HOME/.vimrc"
echo_ok "Creating symlink ~/.vimrc to $script_dir/vim/vimrc."

ln -s "$script_dir/tmux/tmux.conf" "$HOME/.tmux.conf"
echo_ok "Creating symlink ~/.tmux.conf to $script_dir/tmux/tmux.conf."

ln -s "$script_dir/git/gitconfig" "$HOME/.gitconfig"
echo_ok "Creating symlink ~/.gitconfig to $script_dir/git/gitconfig."

echo

echo_user "Reset git user name and email? [y/n]"
read git_reset
if [[ "${git_reset}" == "y" ]]; then
    echo_user "Your git user name :"
    read git_user_name
    git config --global user.name "${git_user_name}"
    echo_ok "Set git user.name to ${git_user_name}"
    echo_user "Your git user email :"
    read git_user_email
    git config --global user.email "${git_user_email}"
    echo_ok "Set git user.email to ${git_user_email}"
fi

# Install vim plugin Vundle
if [[ ! -e ~/.vim/bundle/Vundle.vim ]]; then
    echo_info "You have not install vim plugin Vundle, install it for you."
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    echo_ok "Vundle installed."
fi

# Install tmux plugim tpm
if [[ ! -e ~/.tmux/plugins/tpm ]]; then
    echo_info "You have not install tmux plugin tpm, install it for you."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo_ok "tpm installed."
fi

echo_info "Using Vundle to install other vim plugins ..."
vim +VundleInstall +qall

echo_info "Installing exuberant-ctags for vim plugin TagBar ..."
#install_command exuberant-ctags

echo_info "Installing flake8 for vim plugin vim-flake8"
sudo pip install flake8

echo_info "Installing python-devel, cmake for compiling YouCompleteMe ..."
install_command python-devel
install_command cmake

echo_info "Compiling YouCompleteMe ..."
~/.vim/bundle/YouCompleteMe/install.sh --clang-completer

echo_ok "All Installed!"
