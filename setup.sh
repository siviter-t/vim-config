#!/bin/bash
# \file setup.sh
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

# Check that cmake is accessible too!
if cmake --version >/dev/null 2>&1; then
  echo "Found: $(cmake --version | grep -m 1 -i -s "cmake ")"
else
  echo -e "[$red"Error"$endf] CMake has not been installed. Please install it before" \
          "running this script."
  exit 1
fi

echo -e "Setup from repository: $blue$vimrc_repo_path$endf"
#
# # Check for the YouCompleteMe directory.
# # May fail depending on environment -- see Valloric's installation notes on GitHub.
# echo 'Finding the YouCompleteMe plugin...'
# if [ -d $HOME/.vim/bundle/YouCompleteMe ]; then
#   echo -e "Installing: $green$underline"YouCompleteMe"$endf"
#   cd $HOME/.vim/bundle/YouCompleteMe
#   ./install.sh --clang-completer
# fi

# Fin.
echo 'Note: Some Vim Plugins may require further set-up -- see their documentation.'
echo 'Done!'
exit 0
