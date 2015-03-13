" File: .vimrc
" Author: Taylor Siviter
" Date: March 2015
" Brief: Personal Vim Configuration.
" Copyright: Mozilla Public License, Version 2.0.
" This Source Code Form is subject to the terms of the MPL, v. 2.0. If a copy of the MPL was
" not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
" -------------------------------------------------------------------------------------------- "

" -------------------------- "
" 1.0 "Vimrc Auto-reloading" "
" -------------------------- "
" Automatically reloads the vimrc configuration when Vim detects that its corresponding buffer
" has been written to. Effectively allows realtime customisation of the Vim environment while
" editing the vimrc; unfortunately other Vim instances will still require resourcing.

augroup vimrc_autoreloading
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" ----------------------------- "
" 1.1 "Plugin Manager (Vundle)" "
" ----------------------------- "

set nocompatible " Reset distribution clutter and any options set.
filetype off " Temporarily turn off filetype detection.
set rtp+=~/.vim/bundle/Vundle.vim " Runtime path to Vundle.
call vundle#begin() " Start Vundle management shenanigans.

Plugin 'gmarik/Vundle.vim' " Vundle plug-in mangager.
Plugin 'kien/ctrlp.vim' " File/etc finder.

Plugin 'SirVer/ultisnips' " Code snippets.
Plugin 'Valloric/YouCompleteMe' " Code-completion.
Plugin 'tomtom/tcomment_vim' " Comment toggler.
Plugin 'tpope/vim-fugitive' " Git wrapper.
Plugin 'airblade/vim-gitgutter' " Git diffs linenumbers.

Plugin 'xolox/vim-misc' " Misc functions for xolox Vim plugins.
Plugin 'xolox/vim-easytags' " Automated tag generation and syntax highlighting.
Plugin 'majutsushi/tagbar' " Tagbar for a file

Plugin 'bling/vim-airline' " Status/tabline bar.
Plugin 'reedes/vim-thematic' " Theme control.
Plugin 'tomasr/molokai' " Molokai colourscheme.
Plugin 'altercation/vim-colors-solarized' " Solarized colourscheme.
Plugin 'octol/vim-cpp-enhanced-highlight' " Additional CXX highlighting.

call vundle#end() " End Plugin management.

" ---------------------------- "
" 1.1 "Personal Introductions" "
" ---------------------------- "

let _vim_path=$HOME.'/.vim' " Path to the .vim directory.
let _vim_cache_path=$HOME.'/.cache/vim' " Path to the cache folder for Vim.
let _vim_line_char_limit=96 " Define the character limit per line.
let mapleader=' ' " Setting the Leader keyboard expansion.

" ------------------------ "
" 1.2 "De Facto Standards" "
" ------------------------ "
" Must-have, generic, borderline default options for a useful and sane Vim.

filetype plugin indent on " Enable filetype determined syntax highlighting and indentation.
set wildmenu " Allows wildcards in command-line completion.
set backspace=indent,eol,start " Allow backspacing through indents, end-of-line breaks, etc.
set confirm " Use a dialogue to confirm the saving of externally modified files.
set notimeout ttimeout ttimeoutlen=200 " Time out on keycodes; but do not for keymappings.
set complete-=i " Remove any included files from autocompletion -- tags are better.
set autoread " Reread files that have been changed outside of Vim.
set fileformats=unix,dos,mac " Set the likely fileformats for EOL character reading.

" Enable mouse interactions -- if supported.
if has('mouse')
  set mouse=a
endif

" -------------------------------- "
" 2.0 "Arrangement of the Display" "
" -------------------------------- "
" Setting hidden additionally allows an undo history to be kept for all open buffers, as well
" as a complaining dialogue when quitting from unsaved buffers.

set hidden " Allow the current window to use and switch between unsaved buffers.
set showcmd " Show partial commands on the last line of the screen.
set noshowmode " Do not output the current mode to the last line -- a status bar job.
set showtabline=2 " Force the tabline.
set laststatus=2 " Force the display of the status bar at the bottom.
syntax on " Force syntax highlighting.

" ------------------- "
" 2.1 "Lines&Columns" "
" ------------------- "
" The configuration of the lines and columns of the Vim editor; including character limits,
" text wrapping, and guide-like highlighting. The number of characters per line before wrapping
" is limited to 96 -- as a personal preference -- and can be modified by changing the integer
" value given to the "_vim_line_char_limit" variable.

set ruler " Cursor position displayed in the status bar.
set number " Line numbers in the first column on the left.
set cursorline " Enable hightlighting of the current line.
let &textwidth+=(_vim_line_char_limit-1) " Wrap any written text within the character limit.
let &colorcolumn=_vim_line_char_limit " Enable highlighting of the character limit column.

" -------------------------- "
" Other Stuff To Document... "
" -------------------------- "

set showmatch matchtime=3 " Show any matching brackets when typed -- for 3/10ths of a second.
" Avoiding loss of text from "Ctrl-U" and "Ctrl-W" keyboard shortcuts in insert mode.
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>

" ------------------- "
" 3.X "File Recovery" "
" ------------------- "
" A degree of cushioning if the unthinkable were to happen. These commands will require the
" existence of the swap and backup directories in the the user's ~/.cache/vim folder. This
" path will need to be constructed if it has not been done already.

set nobackup writebackup " Backup files before overwriting them; do not keep them after.
let &directory = _vim_cache_path.'/swap' " Location for the swap dir.
let &backupdir = _vim_cache_path.'/backup' " Location of the backup dir.

" -------------------- "
" 4.1 "Search&Replace" "
" -------------------- "
" Click "Enter" after searching to clear any highlighted matches.

set hlsearch " Highlight search results.
set incsearch " Show any matches in realtime.
set ignorecase smartcase " Case insensitive searching; except when using capital letters.

" Clear any highlighted search results.
nnoremap <silent> <CR> :let @/="" <CR>

" " Text folding
" set foldmethod=syntax
" set foldcolumn=1
" set nofoldenable

" ---------------------------- "
" X.X "Native Exuberant Ctags" "
" ---------------------------- "

set tags=,./.git/tags;,./tags;,./.tags;./TAGS;,./.TAGS; " Common tag places.
let g:easytags_dynamic_files = 1 " Allow project specific tagfiles.
let g:easytags_file = _vim_cache_path.'/gtags' " Location of the global tagfile.
let g:easytags_by_filetype = _vim_cache_path.'/tags/' " Location of filetype specific tagfiles.
let g:easytags_resolve_links = 1 " Resolve symbolic links.

" Tagbar Toggle
nnoremap <F8> :TagbarToggle<CR>

" CtrlP -- Ignore folders with automated/generated content.
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/build/*,*/bin/*,*/doc/*,*/lib/*



" -------------------- "
" X.0 "Plugins and Go" "
" -------------------- "

" ------------------------------------------ "
" X.1 "Update The Status[bar] (vim-airline)" "
" ------------------------------------------ "

let g:airline#extensions#tabline#enabled = 1 " Smarter tab line.
let g:airline#extensions#whitespace#enabled = 0 " Disable whitespace/trailing section.
let g:airline_powerline_fonts = 1 " Enable powerline fonts.

" Check airline/powerline symbol dictionary.
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" Overriding space character for powerline fonts.
let g:airline_symbols.space = "\ua0"

" Available Powerline symbols -- for reference.
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" Airline statusbar configuration.
function! AirlineConfig()
  let g:airline_section_a = airline#section#create(['mode',' ','branch']) " Mode >> Branch
  let g:airline_section_b = airline#section#create_left(['%f','filetype']) " File
  let g:airline_section_c = airline#section#create(['hunks']) " Git Hunks
  let g:airline_section_x = airline#section#create(['%P']) " Percentage
  let g:airline_section_y = airline#section#create(['%{bufnr("%")}B']) " Buffer
  let g:airline_section_z = airline#section#create_right(['%cC','%l']) " Line >> Character
endfunction

" Applying the vim-airline configuration.
augroup vim_airline_config
    autocmd!
    autocmd VimEnter * call AirlineConfig()
augroup END

" --------------------------------------------- "
" X.2 "Colourschemes -> Themes! (vim-thematic)" "
" --------------------------------------------- "
" Allows on-the-fly Vim theming using Vim's command-line. Use ":Thematic <theme>" to load the
" theme named within the angular brackets. Alternatively, use the other Thematic commands, such
" as ":ThematicNext", ":ThematicRandom", etc -- see the autocompletion at the command-line.
" See: https://github.com/reedes/vim-thematic

let g:rehash256 = 1 " Molokai 256 colour terminal.
let g:solarized_termcolors = 256 " Solarized 256 colour terminal.
let g:thematic#theme_name = 'molokai' " Set the default theme to open.

" Available themes.
let g:thematic#themes = {
  \'default' :{
    \'colorscheme': 'industry',
    \'background': 'dark',
    \'airline-theme': 'ubaryd',
  \},
  \'molokai' :{
    \'colorscheme': 'molokai',
    \'background': 'dark',
    \'airline_theme': 'ubaryd',
  \},
  \'solarized_light' :{
    \'colorscheme': 'solarized',
    \'background': 'light',
    \'airline_theme': 'solarized',
  \},
  \'solarized_dark' :{
    \'colorscheme': 'solarized',
    \'background': 'dark',
    \'airline_theme': 'solarized',
  \},
\}

" Lazy hackery for a better airline thematic theme changeover.
function! Better_airline_thematic_changing(theme_name)
  if match(a:theme_name, 'default') || match(a:theme_name, 'molokai')
    let g:airline_theme = 'ubaryd'
    if exists(':AirlineTheme')
      AirlineTheme ubaryd
    endif
  endif
  if match(a:theme_name, 'solarized_light') || match(a:theme_name, 'solarized_dark')
    let g:airline_theme = 'solarized'
    if exists(':AirlineTheme')
      AirlineTheme solarized
    endif
  endif
endfunction

" Set the airline theme on entering...
augroup vim_airline_theme_set
    autocmd!
    autocmd VimEnter * call Better_airline_thematic_changing('g:thematic#theme_name')
augroup END

" ------------------------------- "
" X.3 "Code-snippets (UltiSnips)" "
" ------------------------------- "
" Code Snippets!!

let g:UltiSnipsExpandTrigger = "<F12>"
let g:UltiSnipsListSnippets = "<S-F12>"
let g:UltiSnipsJumpForwardTrigger = "<F12>"
let g:UltiSnipsJumpBackwardTrigger = "<M-F12>"
let g:UltiSnipsSnippetDirectories=["Snippets"]

" ------------------------------------- "
" X.4 "Code-completion (YouCompleteMe)" "
" ------------------------------------- "

let g:ycm_key_list_select_completion = ['<Tab>', '<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_global_ycm_extra_conf = _vim_path.'/YCM/ycm_extra_conf.py'

" --------------------------------------------------------------------------- "
" Additional Cut&Copy (Visual) and Paste Control (Normal/Insert/Visual Modes) "
" --------------------------------------------------------------------------- "
" Allows more natural cut/copy/paste actions; and allows use of the system clipboard -- the
" "d", "y", and "p" shortcuts remain independent and unaffected. Uses the more common shortcuts
" "Ctrl-X", "Ctrl-C", and "Ctrl-V"; coupled with the "+ register -- alias to the X11 clipboard,
" this requires the feature +xterm_clipboard to be compiled with Vim. For non-X11 systems, like
" OSX/Windows, the "* register should be used instead. While either/or registers may work, this
" option is unfortunately particularly system specific.

vnoremap <C-x> "+d<ESC>
vnoremap <C-c> "+y<ESC>
nnoremap <C-v> <ESC>"+p
inoremap <C-v> <C-O>"+p
vnoremap <C-v> "+p<ESC>

" ---------------------------------------------- "
" Save Current File (Normal/Insert/Visual Modes) "
" ---------------------------------------------- "
" Write out or rather save the current file -- if set to "Ctrl-S", it may pause the terminal
" window. Either resume the process with "Ctrl-Q" --  which will not trigger the shortcut;
" disable "Ctrl-S" altogether for the terminal; or personally my favourite method, use "Ctrl-W"
" instead; but allow any key to resume if "Ctrl-S" has been pressed. To do this, BASH users can
" use the command "echo 'stty ixany' >> ~/.bashrc" in a free shell/terminal; before restarting
" any open instances to apply the configuration.

" noremap <C-w> <Esc>:w<CR>
" inoremap <C-w> <Esc>:w<CR>
" vnoremap <C-w> <Esc>:w<CR>

" ------------------- "
" Indentation Control "
" ------------------- "
" Use "Tab" to forward indent the current line and "Shift-Tab" to backwards indent it. Within
" visual mode, the shortcuts will instead perform the indentation on the current selection. The
" action taken can be repeated by using the fullstop, ".". The indentation of the currently
" opened file can be 'fixed' by using "gg" followed by "=G".


set shiftround " Always round indents to a multiple of shiftwidth.
set autoindent " Copy indent from the current line when starting a new line.
set smarttab " Use shiftwidth.
set tabstop=2 shiftwidth=2 " Tab width settings.
set expandtab " Use appropriate spaces instead of tabs.



nnoremap <Tab> <ESC>>>_:ec ""<CR>
nnoremap <S-Tab> <ESC><<_:ec ""<CR>
inoremap <Tab> <C-t><C-o>:ec ""<CR>
inoremap <S-Tab> <C-D><C-o>:ec ""<CR>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" ----------- "
" Tab Control "
" ----------- "
" Use "Ctrl-T" to open a new tab; and "Ctrl-Y" to close it. To swap to the previous tab, use
" "Ctrl-PageUp"; conversely, use "Ctrl-PageDown" to change to the next open tab. If there is no
" adjacent tab open in the direction desired, Vim will loop back to the first or last tab.
" Additionally, the shortcut "Leader-#", where # is a number between 1 and 9, can be used to
" quickly swap to the respective tab. To view any open buffers as tabs, use "Leader-t".

" Maximum number of open tabs per Vim instance.
set tabpagemax=9

" Remap CTRL-T to backspace
noremap <Backspace> <C-T>

" Tab creation and destruction.
nnoremap <silent><C-T> :tabnew<CR>
inoremap <silent><C-T> <Esc>:tabnew<CR>i
vnoremap <silent><C-T> <Esc>:tabnew<CR>v
nnoremap <silent><C-Y> :tabclose<CR>
inoremap <silent><C-Y> <Esc>:tabclose<CR>i
vnoremap <silent><C-Y> <Esc>:tabclose<CR>v

" Open all buffers as tabs (Max=9).
nnoremap <silent><Leader>t :ec "No available buffers to tab"<CR>:tab 9sball<CR>

" If in visual mode, reselect it on tab movement.
vnoremap <silent><C-PageUp> <Esc>:tabprevious<CR>v
vnoremap <silent><C-PageDown> <Esc>:tabnext<CR>v

" Swap to the respectively numbered tab.
noremap <silent><Leader>1 <ESC>1gt
noremap <silent><Leader>2 <ESC>2gt
noremap <silent><Leader>3 <ESC>3gt
noremap <silent><Leader>4 <ESC>4gt
noremap <silent><Leader>5 <ESC>5gt
noremap <silent><Leader>6 <ESC>6gt
noremap <silent><Leader>7 <ESC>7gt
noremap <silent><Leader>8 <ESC>8gt
noremap <silent><Leader>9 <ESC>9gt

" --------------- "
" Comment Control "
" --------------- "
" Use "Leader-D" to comment or decomment the current line; unless Vim is in visual mode; where
" instead the entire selection is either commented in or out -- as appropriate.

noremap <Leader>d :TComment<CR>

"
" Other stuff...


noremap <Leader>p :set paste<CR>
nnoremap <Leader>o :set nopaste<CR>
noremap  <Leader>g :GitGutterToggle<CR>

" this machine config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" ------------------------- "
" X.X "Syntax Highlighting" "
" ------------------------- "

" Recognise doxygen-styled documentation comments.
let g:load_doxygen_syntax=1
" let g:doxygen_enhanced_colour=1

" Customised CXX Metatypes.
let custom_cpp_types=" string_t fun_t int_t real_t complex_t index_t vec_t table_t".
                   \ " colVec_t rowVec_t matrix_t triad_t tetrad_t tensor_t".
                   \ " colVec_ft rowVec_ft matrix_ft triad_ft tetrad_ft tensor_ft".
                   \ " colVec_it rowVec_it matrix_it triad_it tetrad_it tensor_it".
                   \ " resource_t resptr_t"

" Application of any customised CXX syntax.
augroup custom_cpp_syntax
  autocmd!
  execute "autocmd FileType cpp :syntax keyword cppType" .custom_cpp_types
  execute "highlight link cppType Type"
augroup END

" ------------------------- "
" X.X "netrw Configuration" "
" ------------------------- "

" Change the location to save cache files.
let g:netrw_home=_vim_cache_path
