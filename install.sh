#!/bin/bash

#====================================================
# Install dotfiles, create symbol links:
# ~/.vimrc -> from/to/dotfiles/vim/vimrc
# ~/.tmux.conf -> from/to/dotfiles/tmux/tmux.conf
# ~/.gitconfig -> from/to/dotfiles/git/gitconfig
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
    echo -e "  [ ${color_yellow}?${color_end} ] $1"
}

echo_info() {
    echo -e "  [ ${color_blue}...${color_end} ] $1"
}

command_exists() {
    hash "$1" 2>/dev/null
}

# is OS Ubuntu ?
install_command() {
    echo_info "You have not install $1, install it for you."
    sudo apt-get install $1
    echo_ok "$1 installed."
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

# TODO echo 'alias tmux="tmux -2"' >> ~/.bashrc
# is alias tmux exists ?
# TODO setup git user.name and user.email

# Install vim plugin Vundle
if [[ ! -e ~/.vim/bundle/Vundle.vim ]]; then
    echo_info "You have not install vim plugin Vundle, install it for you."
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    echo_ok "Vundle installed."
fi

# TODO ignore vim read vimrc error

echo_info "Using Vundle to install other vim plugins ..."
vim +VundleInstall +qall

echo_info "Installing exuberant-ctags for vim plugin TagBar ..."
sudo apt-get install exuberant-ctags

echo_info "Installing build-essential, python-dev, cmake for compiling YouCompleteMe ..."
sudo apt-get install build-essential python-dev cmake

echo_info "Compiling YouCompleteMe ..."
~/.vim/bundle/YouCompleteMe/install.sh --clang-completer

echo_ok "All Installed."
