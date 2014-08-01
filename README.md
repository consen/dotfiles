# dotfiles

Backup, restore, and sync the prefs and settings for my toolbox.

## Installation

### vimrc

###### 1. install vimrc

```
$ copy vimrc ~/.vimrc
```

###### 2. install vim plugin manager [Vundle](https://github.com/gmarik/Vundle.com)

```
$ git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

Lauch `vim` and run `:VundleInstall`.

Now you can use your brand new and amazing **vim**. The color scheme is [molokai](https://github.com/tomasr/molokai), it works well in terminal vim(not GUI version such as GVim), you can refine molokai.vim to make molokai more monokai.

![vim screenshot](img/vim.png)

### xShell Color Scheme

In menu **Tools**, open **Color Schemes** dialog, then **Import** xShell_color_scheme.xcs, select **taste** in color scheme list.

![xShell screenshot](img/xShell.png)

### gitconfig

```
$ copy gitconfig ~/.gitconfig
```