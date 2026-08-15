    " => General
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Use Neovim's default history of 10000 entries.

    " Enable filetype plugins
    filetype plugin on
    filetype indent on

    " Set to auto read when a file is changed from the outside
    set autoread

    " Fix capitalisation typos of :wq — plain :wq stays native (previous
    " version expanded it to :qa, quitting ALL windows, not just the current)
    cab WQ wq
    cab Wq wq

    " Fast saving
    nmap <leader>w :w!<cr>

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => VIM user interface
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Set 7 lines to the cursor - when moving vertically using j/k
    set scrolloff=7

    " Turn on the WiLd menu
    set wildmenu

    " Turn on numberin
    set number

    " Keep the sign column always visible so diagnostics don't shift the text
    set signcolumn=yes

    " Ignore compiled files
    set wildignore=*.o,*~,*.pyc

    "Always show current position
    set ruler

    " Height of the command bar
    set cmdheight=1

    " Configure backspace so it acts as it should act
    set backspace=eol,start,indent
    set whichwrap+=<,>,h,l

    " Highlight search results
    set hlsearch

    " Makes search act like search in modern browsers
    set incsearch

    " For regular expressions turn magic on
    set magic

    " Show matching brackets when text indicator is over them
    set showmatch
    " How many tenths of a second to blink when matching brackets
    set mat=2

    " No annoying sound on errors
    set noerrorbells
    set novisualbell
    set t_vb=
    set tm=500

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => Colors and Fonts
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Enable syntax highlighting
    syntax enable
    syntax sync minlines=256
    set background=dark
    " Released standalone as https://github.com/axsaucedo/molokai-modern.nvim
    " (installed via plugins.lua)
    colorscheme molokai-modern
    let g:molokai_original = 1
    " Other popular colors
    " colorscheme monokai-phoenix
    set termguicolors " molokai-modern carries true gui colors
    "hi Normal guibg=NONE ctermbg=NONE " Setting transparent background force

    " Set extra options when running in GUI mode
    if has("gui_running")
        set guioptions-=T
        set guioptions+=e
        set t_Co=256
        set guitablabel=%M\ %t
    endif

    " Use Unix as the standard file type
    set ffs=unix,dos,mac

    " Setting syntax for Jenkinsfile
    augroup vimrc_jenkins_filetype
        autocmd!
        autocmd BufNewFile,BufRead Jenkinsfile setf groovy " < activate it with Jenkinsfile
    augroup END

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => Files, backups and undo
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Turn swap files off.
    set noswapfile

    " Put plugins and dictionaries in this dir (also on Windows)
    let vimDir = '$HOME/.vim'
    let &runtimepath.=','.vimDir

    " Keep undo history across sessions by storing it in a file
    if has('persistent_undo')
        let myUndoDir = expand(vimDir . '/undodir')
        if !isdirectory(myUndoDir)
            call mkdir(myUndoDir, 'p')
        endif
        let &undodir = myUndoDir
        set undofile
        set undolevels=1000
        set undoreload=10000
    endif
    " Prune undo files older than 90 days:
    "   find ~/.vim/undodir -type f -mtime +90 -delete

    " Ensure if vim is opened without params the last buffer is opened
    augroup vimrc_last_buffer
        autocmd!
        if argc() == 0
            autocmd VimEnter * nested :edit #<1
        endif
    augroup END

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => Text, tab and indent related
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Use spaces instead of tabs
    set expandtab

    " Be smart when using tabs ;)
    set smarttab

    " 1 tab == 4 spaces
    set shiftwidth=4
    set tabstop=4

    " Make tabs displayed explicitly
    set list
    "set listchars=tab:▶\ ,trail:·,extends:\#,nbsp:⎵
    set listchars=tab:⍿\ ,trail:·,extends:\#,nbsp:⎵

    augroup golang
        autocmd!
        autocmd BufRead *.go set nolist
    augroup END

    set ai "Auto indent
    set si "Smart indent
    set wrap "Wrap lines
    " set nowrap "I don't want wrapping

    " Fix for yaml file
    augroup vimrc_yaml_filetype
        autocmd!
        autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
        autocmd FileType yml setlocal ts=2 sts=2 sw=2 expandtab
    augroup END


    """"""""""""""""""""""""""""""
