
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
"    -> COLOR SYNTAX FOR FILES IN NERDTREE
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
    nnoremap M D

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

    " NERDTree
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    augroup vimrc_nerdtree
        autocmd!
        autocmd StdinReadPre * let s:std_in=1
    " "  Open NARDTree and move to editing area
    " autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | wincmd p | endif

    " Close VIM if all windwos are closed even if the NERD TREE automatically
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

    " NERDTree previously used <S-M>, which collided with vim-cutlass's M mapping.
    nnoremap <leader>n :NERDTreeToggle<CR>

    " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
        autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
            \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

    " Prevent Tab on NERDTree (breaks everything otherwise)
    " autocmd FileType nerdtree noremap <buffer> <Tab> <nop>

    " Set width
    let g:NERDTreeWinSize=30
    let NERDTreeShowHidden=1
    let NERDTreeIgnore=['\.o$', '\.obj$']

    " NERDTress File highlighting
    function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
        exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
        exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
    endfunction

    call NERDTreeHighlightFile('sh', 'green', 'none', 'green', '#151515')
    call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
    call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
    call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
    call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
    call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
    call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
    call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
    call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
    call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
    call NERDTreeHighlightFile('pyc', 'Gray', 'none', 'red', '#151515')
    call NERDTreeHighlightFile('log', 'Gray', 'none', 'red', '#151515')
    call NERDTreeHighlightFile('js', 'Magenta', 'none', '#ffa500', '#151515')
    call NERDTreeHighlightFile('py', 'Magenta', 'none', '#ff00ff', '#151515')
    call NERDTreeHighlightFile('ds_store', 'Gray', 'none', '#686868', '#151515')
    call NERDTreeHighlightFile('gitconfig', 'Gray', 'none', '#686868', '#151515')
    call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#686868', '#151515')
    call NERDTreeHighlightFile('bashrc', 'Gray', 'none', '#686868', '#151515')
    call NERDTreeHighlightFile('bashprofile', 'Gray', 'none', '#686868', '#151515')
    augroup END


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
