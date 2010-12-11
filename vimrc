
syn on                  " syntax highlighting, please

"" Misc:
set nocompatible        " yay
set visualbell          " why would anyone not have this?
set hid                 " don't lose history when moving between buffers
"" Indenting and tabs:
set smartindent         " smart autoindenting
set shiftwidth=4        " doing a '>' should move 4 spaces
set expandtab           " expand tabs to spaces
set nowrap              " don't wrap at 80 chars
set ts=4                " tab stops are 4 spaces
set sts=4               " soft tab stops are 4 spaces
""  Prettiness:
set background=dark     " how to set this depending on whether we're in the UI?
colorscheme liquidcarbon " let's try this for a color scheme
set ruler               " the line at the bottom
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

