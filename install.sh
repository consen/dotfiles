#!/bin/bash

#====================================================
# Install dotfiles, create symbol links:
# ~/.vimrc -> from/to/dotfiles/vim/vimrc
# ~/.tmux.conf -> from/to/dotfiles/tmux/tmux.conf
# ~/.gitconfig -> from/to/dotfiles/git/gitconfig
# and install Vim plugins.
#====================================================

set -e

backup_dir="$HOME/.dotfiles_backup"
dotfiles="vimrc tmux.conf gitconfig"

# TODO colorful echo

# Backup old dotfiles
echo "Creating $backup_dir for backup of any existing dotfiles in $HOME ..."
mkdir -p "$backup_dir"
echo "Done"

for file in $dotfiles; do
    if [[ -f "$HOME/.$file" ]]; then
    	echo "Moving old .$file from $HOME/ to $backup_dir"
    	mv "$HOME/.$file" "$backup_dir"
    fi
done

echo

# Get directory of file install.sh
# So you can run install.sh in dotfiles directory -- ./install.sh
# or any directory out of dotfiles -- ./from/to/dotfiles/install.sh
script_dir="$( cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Creating symlink ~/.vimrc to $script_dir/vim/vimrc ..."
ln -s "$script_dir/vim/vimrc" "$HOME/.vimrc"
echo "Done"

echo "Creating symlink ~/.tmux.conf to $script_dir/tmux/tmux.conf ..."
ln -s "$script_dir/tmux/tmux.conf" "$HOME/.tmux.conf"
echo "Done"

echo "Creating symlink ~/.gitconfig to $script_dir/git/gitconfig ..."
ln -s "$script_dir/git/gitconfig" "$HOME/.gitconfig"
echo "Done"

echo

# TODO setup git user.name and user.email

# Install vim plugin Vundle
if [[ ! -e ~/.vim/bundle/Vundle.vim ]]; then
    echo "Installing vim Plugin Vundle ..."
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    echo "Done"
fi

function command_exists
{
    hash "$1" 2>/dev/null
}

if ! command_exists vim; then
    echo "Installing Vim ..."
    sudo apt-get install vim
    echo "Done"
fi

# TODO ignore vim read vimrc error

echo "Using Vundle to install other vim plugins ..."
vim +VundleInstall +qall
echo "Done"

echo "Installing exuberant-ctags for vim plugin TagBar ..."
sudo apt-get install exuberant-ctags
echo "Done"

echo "Installing build-essential, python-dev, cmake for compiling YouCompleteMe ..."
sudo apt-get install build-essential python-dev cmake
echo "Done"

echo "Compiling YouCompleteMe ..."
~/.vim/bundle/YouCompleteMe/install.sh --clang-completer
echo "Done"
