"" vim-plug setup
"call plug#begin()

"Plug 'ericbn/vim-solarized'
"Plug 'altercation/vim-colors-solarized'
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

"call plug#end()


"" Misc:
set nocompatible        " yay
set visualbell          " why would anyone not have this?
set hid                 " don't lose history when moving between buffers
set modelines=2         " Allow vim: lines to specify the filetype (first / last 2 in the file)
set showcmd             " Show incomplete commands
set bs=2                " Make backspace work in Solaris zones
set shortmess=I         " Don't show the vim welcome text when opening with no filename
set scrolloff=5         " Cursor should never be more than 5 lines from the top or bottom

"" Indenting and tabs:
syn on                  " syntax highlighting, please
filetype plugin indent on   " Turn on indenting
set smartindent         " smart autoindenting
set shiftwidth=4        " doing a '>' should move 4 spaces
set expandtab           " expand tabs to spaces
set nowrap              " don't wrap at 80 chars
set ts=4                " tab stops are 4 spaces
set sts=4               " soft tab stops are 4 spaces

""  Prettiness:
set t_Co=256            " enable 256 colours
set background=dark     " how to set this depending on whether we're in the UI?
let g:solarized_termcolors=256
let g:solarized_termtrans=1     " set transparent background
colorscheme solarized        " let's try this for a color scheme
set ruler               " the line at the bottom

"" Highlighting trailing spaces in red:
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

""  Status line:
set statusline=%F%m%r%h%w\ [%{&ff}-%Y]\ \ %l,%v\ -\ %p%%\ of\ %L\ lines
set laststatus=2

"" Searching:
set hlsearch            " highlight search results
set showmatch           " what does this do?
set ignorecase          " make searches case-insensitive
set smartcase           " ...unless pattern contains uppercase
set incsearch           " start searching as soon as you start typing, and refine as you type more

"" Backups:
set backupdir=~/.vimbackups/
set directory=~/.vimswap/

"" Autocomplete of filenames:
set wildmenu                    " show a menu when autocompleting filenames
set wildmode=list:longest,full  " first complete to the longest match (like bash), then hitting tab gives you a menu of options

"" Plugins:

"" Filetypes:
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2          " 2 spaces for Ruby
" Go:
au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

"" MacVim:
if has("gui_macvim")
  let macvim_hig_shift_movement = 1
endif
