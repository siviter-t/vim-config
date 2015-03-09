#!/bin/bash
# \file install.sh
# \author Taylor Siviter
# \date March 2015
# \copyright Mozilla Public License, Version 2.0.
# This Source Code Form is subject to the terms of the MPL, v. 2.0. If a copy of the MPL was
# not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
# -------------------------------------------------------------------------------------------- #

underline='\e[4m' # Underlined text.
red='\e[31m' # Red text.
green='\e[32m' # Green text.
blue='\e[34m' # Blue text.
magenta='\e[35m' # Magenta text.
endf='\e[0m' # Reset formatting.

vimrc_repo_path=$(cd ${0%/*} && pwd -P) # The absolute path to the repo.

# Check that Vim is accessible! Pointless otherise!
if vim --version >/dev/null 2>&1; then
  echo "Found: $(vim --version | grep -m 1 -i -s "VIM - Vi IMproved")"
else
  echo -e "[$red"Error"$endf] Vim has not been installed. Please install it before" \
          "running this script."
  exit 1
fi

echo -e "Installing from repository: $blue$vimrc_repo_path$endf"

# Check for any previous .vimrc file or symlink; archive if present.
echo 'Checking for a previous .vimrc...'
if [ -f $HOME/.vimrc ]; then
  echo -e "Archiving: $magenta$HOME/.vimrc$endf -> $green$underline$HOME/old.vimrc$endf"
  mv $HOME/.vimrc $HOME/old.vimrc
fi

# Link the .vimrc to the user's home directory.
echo -e "Creating symlink: $magenta$vimrc_repo_path/.vimrc$endf ->" \
        "$green$underline$HOME/.vimrc$endf"
ln -s $vimrc_repo_path/.vimrc $HOME/.vimrc

# Check for any previous .vim directory or symlink; archive if present.
echo 'Checking for a previous .vim directory...'
if [ -d $HOME/.vim ]; then
  echo -e "Archiving: $magenta$HOME/.vim$endf -> $green$underline$HOME/old.vim$endf"
  rm -rf $HOME/old.vim/
  mv $HOME/.vim/ $HOME/old.vim/
fi
# Make a new .vim directory
if [ ! -d $HOME/.vim ]; then
  echo -e "Creating directory -> $green$underline$HOME/.vim$endf"
  mkdir $HOME/.vim
  echo -e "Creating directory -> $green$underline$HOME/.vim/bundle$endf"
  mkdir $HOME/.vim/bundle
fi

# Clone Vundle into the .vim directory from GitHub.
if [ -d $HOME/.vim/bundle ]; then
  echo -e "Installing Vundle -> $green$underline$HOME/.vim/bundle/Vundle.vim$endf"
  git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
  echo -e "Installing other plugins -> $green$underline$HOME/.vim/bundle/*$endf"
  vim +PluginInstall +qall
fi

# Link the Snippets directory into the new .vim directory.
echo -e "Creating symlink: $magenta$vimrc_repo_path/Snippets$endf ->" \
        "$green$underline$HOME/.vim/Snippets$endf"
ln -s $vimrc_repo_path/Snippets $HOME/.vim/Snippets

# Check&Create the relevant cache folders for the user.
echo 'Checking cache directories...'
if [ ! -d $HOME/.cache ]; then
echo -e "Creating directory -> $green$underline$HOME/.cache$endf"
  mkdir $HOME/.cache
fi
if [ ! -d $HOME/.cache/vim ]; then
  echo -e "Creating directory -> $green$underline$HOME/.cache/vim$endf"
  mkdir $HOME/.cache/vim
fi
if [ ! -d $HOME/.cache/vim/backup ]; then
  echo -e "Creating directory -> $green$underline$HOME/.cache/vim/backup$endf"
  mkdir $HOME/.cache/vim/backup
fi
if [ ! -d $HOME/.cache/vim/swap ]; then
  echo -e "Creating directory -> $green$underline$HOME/.cache/vim/swap$endf"
  mkdir $HOME/.cache/vim/swap
fi

# Fin.
echo 'Note: Some Vim Plugins may require further set-up -- see their documentation.'
echo 'Done!'
exit 0
