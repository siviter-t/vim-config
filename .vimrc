" File: .vimrc
" Author: Taylor Siviter
" Date: May 2015
" Brief: Personal Vim Configuration
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
" See: https://github.com/gmarik/Vundle.vim

set nocompatible                                               "< Reset distribution clutter
filetype off                                                   "< Turn off filetype detection
set rtp+=~/.vim/bundle/Vundle.vim                              "< Add runtime path to Vundle
call vundle#begin()                                            "< Start Vundle shenanigans

Plugin 'gmarik/Vundle.vim'                                     "< Vundle plug-in mangager
Plugin 'kien/ctrlp.vim'                                        "< File/etc finder
Plugin 'SirVer/ultisnips'                                      "< Code snippets
Plugin 'tomtom/tcomment_vim'                                   "< Comment toggler
Plugin 'tpope/vim-fugitive'                                    "< Git wrapper
Plugin 'tpope/vim-speeddating'                                 "< Clever date incrementing
Plugin 'airblade/vim-gitgutter'                                "< Git diffs linenumbers
Plugin 'xolox/vim-misc'                                        "< Misc functions for xolox
Plugin 'xolox/vim-easytags'                                    "< Tag and syntax generation
Plugin 'majutsushi/tagbar'                                     "< Tagbar for a file
Plugin 'vim-airline/vim-airline'                               "< Status/tabline bar
Plugin 'vim-airline/vim-airline-themes'                        "< Themes for the bar
Plugin 'tomasr/molokai'                                        "< Molokai colourscheme
Plugin 'altercation/vim-colors-solarized'                      "< Solarized colourscheme
Plugin 'octol/vim-cpp-enhanced-highlight'                      "< Additional CXX highlighting
Plugin 'Valloric/YouCompleteMe'                                "< Code-completion

call vundle#end()                                              "< End Vundle management

" ---------------------------- "
" 1.2 "Personal Introductions" "
" ---------------------------- "

let _vim_path=$HOME.'/.vim'                                    "< Path to the .vim directory
let _vim_cache_path=$HOME.'/.cache/vim'                        "< Path to the cache dir
let _vim_line_char_limit=96                                    "< Character limit per line
let mapleader=' '                                              "< Leader key expansion

" Ignore the following places or files in wildcard expansion.
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/build/*,*/bin/*,*/doc/*,*/lib/*
let g:netrw_home=_vim_cache_path                               "< Change netrw cache dir
" Customise and move viminfo to cache.
let &viminfo = "f1,'100,:250,/250,<1000,s100,h,n"._vim_cache_path.'/viminfo'

" ------------------------ "
" 1.3 "De Facto Standards" "
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
set encoding=utf-8

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

" --------------------- "
" 2.1 "Lines & Columns" "
" --------------------- "
" The configuration of the lines and columns of the Vim editor; including character limits,
" text wrapping, and guide-like highlighting. The number of characters per line before wrapping
" is limited to 96 -- as a personal preference -- and can be modified by changing the integer
" value given to the "_vim_line_char_limit" variable.

set ruler " Cursor position displayed in the status bar.
set number " Line numbers in the first column on the left.
set cursorline " Enable hightlighting of the current line.
let &textwidth+=(_vim_line_char_limit-1) " Wrap any written text within the character limit.
let &colorcolumn=_vim_line_char_limit " Enable highlighting of the character limit column.

" ---------------------- "
" 2.2 "Tabs for Buffers" "
" ---------------------- "
" Use "Ctrl-T" to open a new tab; and "Ctrl-Y" to close it. To swap to the previous tab, use
" "Leader-Left"; conversely, use "Leader-Right" to change to the next open tab. If there is no
" adjacent tab open in the direction desired, Vim will loop back to the first or last tab.
" Additionally, the shortcut "Leader-#", where # is a number between 1 and 9, can be used to
" quickly swap to the respective tab. To view any open buffers as tabs, use "Leader-t".

" Maximum number of open tabs per Vim instance.
set tabpagemax=9

" Remap CTRL-T to backspace.
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

nnoremap <silent><Leader><Left> <Esc>:tabprevious<CR>
nnoremap <silent><Leader><Right> <Esc>:tabnext<CR>

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

" --------------------------- "
" 3.0 "Workflow Manipulation" "
" --------------------------- "

set showmatch matchtime=3 " Show any matching brackets when typed -- for 3/10ths of a second.

" Avoiding loss of text from "Ctrl-U" and "Ctrl-W" keyboard shortcuts in insert mode.
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>

" ------------------------------------- "
" 3.1 "A Familiar Cut, Copy, and Paste" "
" ------------------------------------- "
" Allows more natural cut/copy/paste actions; and allows use of the system clipboard -- the
" "d", "y", and "p" shortcuts remain independent and unaffected. Uses the familiar "Leader-X",
" "Ctrl-C", and "Ctrl-V"; coupled with the "+ register -- alias to the X11 clipboard, this
" requires the feature +xterm_clipboard to be compiled with Vim. For non-X11 systems, like
" OSX/Windows, the "* register should be used instead. While either/or registers may work, this
" option is unfortunately particularly system specific.

vnoremap <Leader>x "+d<ESC>
vnoremap <C-c> "+y<ESC>
nnoremap <C-v> <ESC>"+p
inoremap <C-v> <C-O>"+p
vnoremap <C-v> "+p<ESC>

" --------------------- "
" 3.2 "Familiar Saving" "
" --------------------- "
" Saving the current file with the familiar shortcut, "Ctrl-S"! Due to a similar and almost
" archaic shortcut in many terminal emulators, it is likely that this method will fail to work
" with terminal Vim; the shortcut will be overriden and instead pause the workflow -- appearing
" to the uninitiated as a frozen Vim window. Workflow is resumed with the shortcut, "Ctrl-Q"; 
" however a more natural approach would be to allow any key to trigger resumption; BASH users
" can do this by using the command "echo 'stty ixany' >> ~/.bashrc" in a free shell/terminal.

noremap <C-s> <Esc>:w<CR>
inoremap <C-s> <Esc>:w<CR>
vnoremap <C-s> <Esc>:w<CR>

" ------------------------- "
" 3.3 "Natural Indentation" "
" ------------------------- "
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

" ---------------------- "
" 3.4 "Search & Replace" "
" ---------------------- "
" Click "Enter" after searching to clear any highlighted matches.

set hlsearch " Highlight search results.
set incsearch " Show any matches in realtime.
set ignorecase smartcase " Case insensitive searching; except when using capital letters.

" Clear any highlighted search results.
nnoremap <silent> <CR> :let @/="" <CR>

" -------------------- "
" 3.5 "Spell checking" "
" -------------------- "
" Use "F7" to toggle spell check; for a list of suggestions, move to the misspelled word and
" use "Leader-z" or "z=".

set spelllang=en_gb                                            "< British English
noremap <F7> :setlocal spell!<CR>
inoremap <F7> <C-O>:setlocal spell!<CR>
noremap <Leader>z z=

" -------------------------------- "
" 4.0 "Programming-specific Magic" "
" -------------------------------- "

set tags=,./.git/tags;,./tags;,./.tags;./TAGS;,./.TAGS; " Common tagfile places.

" -------------------------------- "
" 4.1 "Forced Syntax Highlighting" "
" -------------------------------- "

" Recognise doxygen-styled documentation comments.
let g:load_doxygen_syntax=1
" let g:doxygen_enhanced_colour=1

" Customised CXX Metatypes.
let custom_cpp_types=" integer_t int_t real_t flt_t complex_t cplx_t index_t idx_t".
                   \ " string_t str_t vector_t vec_t table_t tab_t function_t fun_t".
                   \ " ptr_t uptr_t sptr_t wptr_t resource_t res_t resouceptr_t resptr_t".
                   \ " colVec_t rowVec_t matrix_t triad_t tetrad_t tensor_t"

" Application of any customised CXX syntax.
augroup custom_cpp_syntax
  autocmd!
  execute "autocmd FileType cpp :syntax keyword cppType" .custom_cpp_types
  execute "highlight link cppType Type"
augroup END

" ------------------- "
" 5.0 "File Recovery" "
" ------------------- "
" A degree of cushioning if the unthinkable were to happen. These commands will require the
" existence of the swap and backup directories in the the user's ~/.cache/vim folder. This
" path will need to be constructed if it has not been done already.

set nobackup writebackup " Backup files before overwriting them; do not keep them after.
let &directory = _vim_cache_path.'/swap' " Location for the swap dir.
let &backupdir = _vim_cache_path.'/backup' " Location of the backup dir.

" --------------------------------- "
" 6.0 "GVim Specific Configuration" "
" --------------------------------- "
" Configures the GUI version of Vim. To align with the terminal version, this removes all the
" added clutter; including menubars, toolbars, and scrollbars.

if has('gui_running')
  set guioptions-=M " Remove and do not source the menubar.
  set guioptions-=T " Remove the toolbar.
  set guioptions-=r " Remove right-hand scrollbar.
  set guioptions-=L " Remove left-hand scrollbar.
endif

" -------------------- "
" 7.0 "Plugins and Go" "
" -------------------- "

" ------------------------------------------ "
" 7.1 "Update The Status[bar] (vim-airline)" "
" ------------------------------------------ "
" A lovely statusbar -- and a better tabbar. Requires the installation of Powerline fonts for
" both the terminal and GUI versions of Vim -- see the documentation from the repositories
" listed below. An important caveat for terminal usage, the emulator used for Vim must have one
" of the prepatched Powerline fonts set as the current font; otherwise, it will not be used. 
" See: https://github.com/bling/vim-airline
" See: https://github.com/powerline/fonts

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
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = ''

" Airline statusbar configuration.
function! AirlineConfig()
  let g:airline_section_a = airline#section#create(['mode',' ','branch']) " Mode >> Branch
  let g:airline_section_b = airline#section#create_left(['%f','filetype']) " File
  let g:airline_section_c = airline#section#create(['hunks']) " Git Hunks
  let g:airline_section_x = airline#section#create(['%P']) " Percentage
  " let g:airline_section_y = airline#section#create(['%{bufnr("%")}B']) " Buffer
  let g:airline_section_y = airline#section#create(['']) " Buffer
  let g:airline_section_z = airline#section#create_right(['%cC','%l']) " Line >> Character
endfunction

" Applying the vim-airline configuration.
augroup vim_airline_config
    autocmd!
    autocmd VimEnter * call AirlineConfig()
augroup END

" Fixing UI glitches
function! RefreshUI()
  if exists(':AirlineRefresh')
    AirlineRefresh
  else
    " Clear & redraw the screen, then redraw all statuslines.
    redraw!
    redrawstatus!
  endif
endfunction

au BufWritePost .vimrc source $MYVIMRC | :call RefreshUI()
au VimEnter * call RefreshUI()

" ------------------- "
" 7.2 "Colourschemes" "
" ------------------- "
" To be customised ad hoc when required.

set background=dark
colorscheme solarized

"let g:rehash256 = 1 " Molokai 256 colour terminal.
"let g:solarized_termcolors = 256 " Degraded Solarized 256 colour terminal.

" ------------------------------- "
" 7.3 "Code-snippets (UltiSnips)" "
" ------------------------------- "
" See: https://github.com/SirVer/ultisnips

let g:UltiSnipsExpandTrigger = "<F12>"
let g:UltiSnipsListSnippets = "<S-F12>"
let g:UltiSnipsJumpForwardTrigger = "<F12>"
let g:UltiSnipsJumpBackwardTrigger = "<M-F12>"
let g:UltiSnipsSnippetDirectories=["Snippets"]

" ------------------------------------- "
" 7.4 "Code-completion (YouCompleteMe)" "
" ------------------------------------- "
" See: https://github.com/Valloric/YouCompleteMe

let g:ycm_key_list_select_completion = ['<Tab>', '<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_global_ycm_extra_conf = _vim_path.'/YCM/ycm_extra_conf.py'

" ------------------------------------------------ "
" 7.5 "Better Exuberant Ctags (easytags & tagbar)" "
" ------------------------------------------------ "
" See: https://github.com/xolox/vim-easytags
" See: https://github.com/majutsushi/tagbar

let g:easytags_dynamic_files = 1 " Allow project specific tagfiles.
let g:easytags_file = _vim_cache_path.'/gtags' " Location of the global tagfile.
let g:easytags_by_filetype = _vim_cache_path.'/tags/' " Location of filetype specific tagfiles.
let g:easytags_resolve_links = 1 " Resolve symbolic links.

" Tagbar Toggle
nnoremap <F8> :TagbarToggle<CR>

" --------------- "
" 7.6 "Comments!" "
" --------------- "
" Use "Leader-D" to comment or decomment the current line; unless Vim is in visual mode; where
" instead the entire selection is either commented in or out -- as appropriate.
" See: https://github.com/tomtom/tcomment_vim

noremap <Leader>d :TComment<CR>

" ---------------------------------------- "
" 7.7 "Git Git Git (fugitive & gitgutter)" "
" ---------------------------------------- "
" See: https://github.com/tpope/vim-fugitive
" See: https://github.com/airblade/vim-gitgutter

noremap  <Leader>g :GitGutterToggle<CR>
