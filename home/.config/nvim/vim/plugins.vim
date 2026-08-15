
"    Y8b Y88888P 888     e   e
"     Y8b Y888P  888    d8b d8b
"      Y8b Y8P   888   e Y8b Y8b
"       Y8b Y    888  d8b Y8b Y8b
"        Y8P     888 d888b Y8b Y8b

"      e88'Y88   e88 88e   Y88b Y88 888'Y88
"     d888  'Y  d888 888b   Y88b Y8 888 ,'Y
"    C8888     C8888 8888D b Y88b Y 888C8
"     Y888  ,d  Y888 888P  8b Y88b  888 "
"      '88,d88   '88 88'   88b Y88b 888


" Sections:
"    -> Plugin configuration
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"    -> (file explorer lives in plugins.lua: neo-tree)
"
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Setting grep with rg
    set grepprg=rg\ --vimgrep\ --smart-case\ --follow

    set lazyredraw            " improve scrolling performance when navigating through large results
    set ignorecase smartcase  " ignore case only when the pattern contains no capital letters

    " Plug pandoc for markdown
     let g:pandoc#syntax#conceal#use = 0
     let g:pandoc#folding#level = 3
     let g:pandoc#folding#fdc = 0
     let g:pandoc#syntax#codeblocks#embeds#use = 1
     let g:pandoc#syntax#codeblocks#embeds#langs = ["yaml", "bash=sh", "sh", "python", "json", "go"]

    " Removing conceal default not just markdown but laso help doc
    set conceallevel=0
    set concealcursor=

    " Plug 'preservim/vim-markdown'
    let g:vim_markdown_folding_style_pythonic = 1
    let g:vim_markdown_folding_level = 3

    " iamcco/markdown-preview.nvim
    let g:mkdp_browser = 'firefox'
    let g:mkdp_theme = 'dark'

    " Python3 provider (used by vim-pandoc); without an explicit pin nvim
    " falls into pyenv shim resolution and fails to load the host
    let g:python3_host_prog="~/.pyenv/versions/3.10.5/bin/python"

    " Tags
    set tags=./.tags,.tags;

    " Easyclip / Now Clutlass.vim https://github.com/svermeulen/vim-cutlass
    set clipboard=unnamedplus
    nnoremap m d
    xnoremap m d

    nnoremap mm dd
    " M belongs to neo-tree (see plugins.lua); cut-to-eol is m$

    " With a map leader it's possible to do extra key combinations
    " like <leader>w saves the current file
    let mapleader = ","
    let g:mapleader = ","

    " Grug Far
    nnoremap <leader>fr :GrugFar<CR>

    " Airline status line
    let g:airline#extensions#tabline#enabled = 1
    " buffer_idx_mode and its <leader>1..9 tab maps removed: unused, and
    " they cluttered the which-key leader popup
    let g:airline_powerline_fonts = 1
    let g:airline_theme = "wombat"


    function! AirlineInit()
        let g:airline_section_a = airline#section#create(['😈 ', 'branch', '%{&paste?"📋✔":"📋⚪"}'])
        let g:airline_section_b = airline#section#create_left(['mode'])
        let g:airline_section_c = airline#section#create(['🔍 ', 'file'])
    endfunction
    augroup vimrc_airline
        autocmd!
        autocmd User AirlineAfterInit call AirlineInit()
    augroup END
    let g:airline#extensions#nvimlsp#enabled = 1

    " Bullets.vim
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    let g:bullets_enabled_file_types = [
        \ 'markdown',
        \ 'text',
        \ 'gitcommit',
        \ 'scratch'
        \]

    " File explorer is neo-tree (see plugins.lua): M or <leader>e toggles,
    " <leader>n retained for muscle memory
    nnoremap <leader>n :Neotree toggle<CR>


    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " rainbow parentheses
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    let g:rainbow_active = 1
    let g:rainbow_conf = {
        \   'guifgs': ['darkorange3', 'seagreen3', 'firebrick', 'royalblue3' ],
        \   'ctermfgs': ['lightyellow', 'lightmagenta', 'lightblue', 'lightcyan' ],
        \}



    """"""""""""""""""""""""""""""
    " => Status line
    """"""""""""""""""""""""""""""
    " Always show the status line
    set laststatus=2
