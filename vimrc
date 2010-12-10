
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
"" Backups:
set backupdir=~/.vimbackups/
set directory=~/.vimswap/

