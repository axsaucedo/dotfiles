
" The original VIMRC file was initially obtained by Amir Salihefendic
"   for more details read the end of this file.
"
" Sections:
"    -> Vim-plug configuration
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


    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => Vim-plug setup
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

    " Setup vim-plug
    call plug#begin('~/.vim/plugged')

    " Enable plugins
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Nerd tree side directory
    Plug 'scrooloose/nerdtree'
    " NERDTree git plugin
    Plug 'Xuyuanp/nerdtree-git-plugin'
    " Icons for NERDTree - Disabling as WSL doesn't support
    " Plug 'ryanoasis/vim-webdevicons'
    " fuzzy search
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    " Colour parentheses
    Plug 'luochen1990/rainbow'
    " Multiple cursros
    Plug 'terryma/vim-multiple-cursors'
    " Python syntax
    "Plug 'hdima/python-syntax'
    " Plug 'honza/vim-snippets'
    " Markdown preview
    Plug 'junegunn/vim-xmark', { 'do': 'make' }
    " Adding support for YCM
    " Plug 'Valloric/YouCompleteMe'
    " Navigation between tmux and vim
    Plug 'christoomey/vim-tmux-navigator'
    " Smooth scroll
    Plug 'terryma/vim-smooth-scroll'
    " Complete closing parentheses/brackets - Replaced with vanilla remap
    Plug 'jiangmiao/auto-pairs'
    " Plug 'Raimondi/delimitMate'
    " Fugitive plugin
    Plug 'tpope/vim-fugitive'
    " NERD Commenter
    Plug 'scrooloose/nerdcommenter'
    " Bulletpoint plug
    Plug 'dkarter/bullets.vim'
    " COC Autocompllete
    " See https://octetz.com/docs/2019/2019-04-24-vim-as-a-go-ide/ for
    " autocomplete setup for golang
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Emmet Vim (Autocomplete of HTML)
    Plug 'mattn/emmet-vim'
    " Vim airline status line
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " Vim Repeat
    Plug 'tpope/vim-repeat'
    " Vim Easyclip
    Plug 'svermeulen/vim-easyclip'
    " Enhanced go
    Plug 'fatih/vim-go'
    " Markdown preview
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
    " Dim inactive (First plugin is to listen to tmux events, other to dim)
    Plug 'tmux-plugins/vim-tmux-focus-events'
    Plug 'blueyed/vim-diminactive' " Linked to plugin above
    " Syntax highlighting for log files
    Plug 'mtdl9/vim-log-highlighting'
    " Python black formatter (for concistent format)
    Plug 'ambv/black'
    " ADd all popular colorschemes available
    Plug 'flazz/vim-colorschemes'
    " Cycle through all colorschemes with f4 
    Plug 'vim-scripts/CycleColor'
    " Add colours to hex
    Plug 'etdev/vim-hexcolor'
    " Sidebar minimap - COMMENTING OUT: Too slow
    " Plug 'severin-lemaignan/vim-minimap'
    Plug 'alvan/vim-closetag'
    " Shortcuts to add/remove quotes/brances on selection
    Plug 'tpope/vim-surround'
    " Set paste automatically
    Plug 'roxma/vim-paste-easy'
    " Autocomplete (instead of supertab)
    " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    " Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
    " Snippets
    " Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    " Libsonnet file 
    Plug 'google/vim-jsonnet'
    " Multi-language rich syntax support Syntax
    Plug 'sheerun/vim-polyglot'
    " Advanced syntax support for cpp
    Plug 'octol/vim-cpp-enhanced-highlight'
    " cpp proto function codegen with :GenDefinition & :GetDeclaration
    Plug 'vim-scripts/a.vim' " dependency for below and is used to switch from header to definition file
    Plug 'tenfyzhong/vim-gencode-cpp'





    " Vanilla auto close parens and quotes
    " inoremap " ""<left>
    " inoremap ' ''<left>
    " inoremap ( ()<left>
    " inoremap [ []<left>
    " inoremap { {}<left>
    " inoremap {<CR> {<CR>}<ESC>O
    " inoremap {;<CR> {<CR>};<ESC>O

    " Setup NVIM
    let g:python3_host_prog=$CONDA_PREFIX."/bin/python"

    " Guten Tags
    set tags=./.tags,.tags;

    let g:gutentags_ctags_tagfile = '.tags'
    let g:gutentags_file_list_command = 'rg --files . $CONDA_PREFIX'
    let g:gutentags_generate_on_new = 1

    " Previm
    let g:previm_open_cmd = "open -a 'Google Chrome'"

    " Easyclip
    "set clipboard=unnamed
    "let g:EasyClipShareYanks=1

    " Enable for WSL clipboard
    let s:clip = '/c/Windows/System32/clip.exe'  " default location
    if executable(s:clip)
        augroup WSLYank
            autocmd!
            autocmd TextYankPost * call system('echo '.shellescape(join(v:event.regcontents, "\<CR>")).' | '.s:clip)
        augroup END
    end
    noremap <C-C> :call system('/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Command Get-Clipboard')<CR> 
    " For slowdown
    "set eventignore=TextYankPost
    
    

    " Airline status line
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#buffer_idx_mode = 1
    let g:airline_powerline_fonts = 1
    let g:airline_theme = "wombat"

    nmap 1 <Plug>AirlineSelectTab1
    nmap 2 <Plug>AirlineSelectTab2
    nmap 3 <Plug>AirlineSelectTab3
    nmap 4 <Plug>AirlineSelectTab4
    nmap 5 <Plug>AirlineSelectTab5
    nmap 6 <Plug>AirlineSelectTab6
    nmap 7 <Plug>AirlineSelectTab7
    nmap 8 <Plug>AirlineSelectTab8
    nmap 9 <Plug>AirlineSelectTab9

    " Function that displays various different type of details form CoC.vim
    " syntax plugins based on language server
    function! ErrorsDiagnostic() abort
      let info = get(b:, 'coc_diagnostic_info', {})
      if empty(info) | return '' | endif
      let msgs = []
      if get(info, 'error', 0)
        call add(msgs, ' 💀 ERRORS: ' . info['error'] . ' 💀 ')
      endif
      return join(msgs, ' ')
    endfunction

    function! WarningsDiagnostic() abort
      let info = get(b:, 'coc_diagnostic_info', {})
      if empty(info) | return '' | endif
      let msgs = []
      if get(info, 'warning', 0)
        call add(msgs, '  🤓 WARNINGS: ' . info['warning'] . ' 🤓 ')
      endif
      return join(msgs, ' ')
    endfunction

    function! CoCDiagnostic() abort
      let info = get(b:, 'coc_diagnostic_info', {})
      if empty(info) | return '' | endif
      let msgs = []
      return get(g:, 'coc_status', '')
    endfunction

    function! AirlineInit()
            let g:airline_section_a = airline#section#create(['mode', '😈 ', 'branch'])
        let g:airline_section_b = airline#section#create_left(['file'])
        let g:airline_section_c = airline#section#create(['🔍 %#Error#%{ErrorsDiagnostic()}%*%#WarningMsg#%{WarningsDiagnostic()}%*%#Error#%{CoCDiagnostic()}%*%#Pmenu#'])
    endfunction
    autocmd User AirlineAfterInit call AirlineInit()


    let g:airline#extensions#coc#enabled = 1
    
    " Geeknote 
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " let g:GeeknoteFormat="markdown"

    " nnoremap <S-M> :Geeknote<CR>

    " Bullets.vim
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    let g:bullets_enabled_file_types = [
        \ 'markdown',
        \ 'text',
        \ 'gitcommit',
        \ 'scratch'
        \]
   
    " Finishing plugin list
    call plug#end()

    " NERDTree 
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    autocmd StdinReadPre * let s:std_in=1
    " "  Open NARDTree and move to editing area
    " autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | wincmd p | endif

    " Close VIM if all windwos are closed even if the NERD TREE automatically
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

    " Allow for Ctrl+n to be shortcut to open nerdtree in the working directory
    nnoremap <S-M> :NERDTreeToggle<CR>

    " Set width
    let g:NERDTreeWinSize=30
    let NERDTreeShowHidden=1

    " FZF
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " This function ensures that we use the relevant search depending on whether we
    "   are in a git repo or not
    fun! FzfOmniFiles()
        let is_git = system('git status')
        if v:shell_error
            :Files
        else
            :GFiles
        endif
    endfun
    noremap <C-p><C-p> :call FzfOmniFiles()<CR> 
    noremap <C-p><C-b> :Buffers<CR>
    noremap <C-p><C-f> :Ag<CR>
    noremap <C-p><C-g> :GGrep<CR>
    noremap <C-p><C-t> :Tags<CR>
    " noremap <C-p><C-g> :GFiles?<CR>
    noremap <C-p><C-l> :BLines<CR>
    noremap <C-p><C-c> :Commits<CR>

    " rainbow parentheses
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    let g:rainbow_active = 1
    let g:rainbow_conf = {
        \   'guifgs': ['darkorange3', 'seagreen3', 'firebrick', 'royalblue3' ],
        \   'ctermfgs': ['lightyellow', 'lightmagenta', 'lightblue', 'lightcyan' ],
        \}

    " Enabling snippets
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " let g:UltiSnipsExpandTrigger="<c-s>"
    "let g:UltiSnipsJumpForwardTrigger="<c-b>"
    "let g:UltiSnipsJumpBackwardTrigger="<c-z>"
    
    " Smooth scrolling
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
    " noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
    " noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
    " noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

    " Snippets
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " let g:UltiSnipsExpandTrigger = "<Tab>"
    " let g:UltiSnipsJumpForwardTrigger = "<Tab>"
    " let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"
    " let g:UltiSnipsMappingsToIgnore = ['autocomplete']
    
    """"""""""""""""""""""""""""""
    " => Status line
    """"""""""""""""""""""""""""""
    " Always show the status line
    set laststatus=2

    " -------------------------------------------------------------------------------------------------
    " GoLang settings
    " See https://octetz.com/docs/2019/2019-04-24-vim-as-a-go-ide/
    " -------------------------------------------------------------------------------------------------


    " coc.nvim default settings
    " -------------------------------------------------------------------------------------------------
    "  Notes:
    "  High level:
    "  * Config file can be located at ~/.config/nvim/coc-settings.json
    "  * It can also be accessed through CocConfig
    "  * Currently integrated with airline statusline (errors/warnings & load)
    "
    "  The current plugins expected to be installed include:
    "  * CocInstall coc-python
    "  * CocInstall coc-go
    "  * CocInstall coc-clangd - also requires clangd to be installed
    "  * For C can also use others https://github.com/neoclide/coc.nvim/wiki/Language-servers#ccobjective-c
    "  * CocInstall coc-cmake
    "  * Bash - currently manually added to settings
    "  * CocInstall coc-snippets - Adds snippet functionality
    "  * CocInstall coc-highlight - Introduces overrides for coc diagnostic
    "  syntax highlights such as errors and warnings
    "
    "  Other expected requirements:
    "  * Python server expects update of Palantir's Python language server
    "  * Setup bash language server (node dependent) https://github.com/bash-lsp/bash-language-server

    " TextEdit might fail if hidden is not set.
    set hidden

    " Some servers have issues with backup files, see #649.
    set nobackup
    set nowritebackup

    " Give more space for displaying messages.
    set cmdheight=2

    " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
    " delays and poor user experience.
    set updatetime=300

    " Don't pass messages to |ins-completion-menu|.
    set shortmess+=c

    " Always show the signcolumn, otherwise it would shift the text each time
    " diagnostics appear/become resolved.
    if has("patch-8.1.1564")
      " Recently vim can merge signcolumn and number column into one
      set signcolumn=number
    else
      set signcolumn=yes
    endif

    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    " USE THIS ONE IF NO OTHER PLUGINS:
    """ inoremap <silent><expr> <TAB>
    """       \ pumvisible() ? "\<C-n>" :
    """       \ <SID>check_back_space() ? "\<TAB>" :
    """       \ coc#refresh()
    """ inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
    """
    " USE THIS ONE IF USING COC SNIPPET PLUGIN:
    inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
    let g:coc_snippet_next = '<tab>' 
    """

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
    " position. Coc only does snippet and additional edit on confirm.
    " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
    if exists('*complete_info')
      inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
    else
      inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    endif

    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)
    nmap <silent> [e <Plug>(coc-diagnostic-prev-error)
    nmap <silent> ]e <Plug>(coc-diagnostic-next-error)

    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window.
    " This opens the documentation and the function signature if available
    " If opening this on top of a function it will show two popups
    " If you just add a command and wait inside a function the signature would
    " still pop-up
    nnoremap  <M-k> :call <SID>show_documentation()<CR>:call CocActionAsync('showSignatureHelp')<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')
    nnoremap <M-i> :call CocActionAsync('highlight')<CR>

    " Symbol renaming.
    nmap <leader>rn <Plug>(coc-rename)

    " Formatting selected code.
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder.
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Applying codeAction to the selected region.
    " Example: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap keys for applying codeAction to the current buffer.
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Apply AutoFix to problem on the current line.
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Map function and class text objects
    " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
    xmap if <Plug>(coc-funcobj-i)
    omap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap af <Plug>(coc-funcobj-a)
    xmap ic <Plug>(coc-classobj-i)
    omap ic <Plug>(coc-classobj-i)
    xmap ac <Plug>(coc-classobj-a)
    omap ac <Plug>(coc-classobj-a)

    " Use CTRL-S for selections ranges.
    " Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
    nmap <silent> <C-s> <Plug>(coc-range-select)
    xmap <silent> <C-s> <Plug>(coc-range-select)

    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocAction('format')

    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    " Add (Neo)Vim's native statusline support.
    " NOTE: Please see `:h coc-status` for integrations with external plugins that
    " provide custom statusline: lightline.vim, vim-airline.

    " Mappings using CoCList:
    " Show all diagnostics.
    nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions.
    nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
    " Show commands.
    nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document.
    nnoremap <silent> <space>s  :<C-u>CocList outline<cr>
    " Search workspace symbols.
    nnoremap <silent> <space>o  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list.
    nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
    
    " coc snippets settings:
    " Use <C-l> for trigger snippet expand.
    imap <C-l> <Plug>(coc-snippets-expand)
    " Use <C-j> for select text for visual placeholder of snippet.
    vmap <C-j> <Plug>(coc-snippets-select)
    " Use <C-j> for jump to next placeholder, it's default of coc.nvim
    let g:coc_snippet_next = '<c-j>'
    " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
    let g:coc_snippet_prev = '<c-k>'
    " Use <C-j> for both expand and jump (make expand higher priority.)
    imap <C-j> <Plug>(coc-snippets-expand-jump)

    " Language specific
    "
    " Python Conda - Currently unused
    " Optional to add if want conda to be added for current environment:
    " if $CONDA_PREFIX == ""
    "   let s:current_python_path=$CONDA_PYTHON_EXE
    " else
    "   let s:current_python_path=$CONDA_PREFIX.'/bin/python'
    " endif
    " call coc#config('python', {'pythonPath': s:current_python_path})
    "
    " Godot
    " Currently can be accessed directly through official language server
    " https://github.com/godotengine/godot/issues/34523#issuecomment-582144661
    
    " CPP C++
    " Syntax:
    "let g:cpp_class_scope_highlight = 1
    let g:cpp_member_variable_highlight = 1
    let g:cpp_class_decl_highlight = 1
    "let g:cpp_posix_standard = 1
    "let g:cpp_experimental_simple_template_highlight = 1
    "let g:cpp_experimental_template_highlight = 1

    " a.vim override to work with cpp with h files
    " With this and the cppgenplugin you can generate cpp
    " body by using the :GenDefinition or :GenDeclaration cmds
    let g:alternateExtensions_CPP = "inc,h,H,HPP,hpp"
    let g:alternateExtensions_cpp = "inc,h,H,HPP,hpp"
    let g:alternateExtensions_h = "cpp"
    let g:alternateExtensions_H = "cpp"

    " VIMGO SETTINGS:
    " -------------------------------------------------------------------------------------------------

    let g:go_highlight_build_constraints = 1
    let g:go_highlight_extra_types = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_structs = 1
    let g:go_highlight_types = 1

    let g:go_fmt_command = "gofmt"
    let g:go_def_mode='gopls'
    let g:go_info_mode='gopls'

    let g:go_fmt_fail_silently = 1 
    let g:go_def_mapping_enabled = 0


    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => General
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Sets how many lines of history VIM has to remember
    set history=700

    " Enable filetype plugins
    filetype plugin on
    filetype indent on

    " Set to auto read when a file is changed from the outside
    set autoread

    " With a map leader it's possible to do extra key combinations
    " like <leader>w saves the current file
    let mapleader = ","
    let g:mapleader = ","

    " Mapping WQ to w q 
    command! WQ wq
    command! Wq wq
    command! W w
    command! Q q

    " Fast saving
    nmap <leader>w :w!<cr>

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => VIM user interface
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Set 7 lines to the cursor - when moving vertically using j/k
    set so=7

    " Turn on the WiLd menu
    set wildmenu

    " Turn on numberin
    set number

    " Ignore compiled files
    set wildignore=*.o,*~,*.pyc

    "Always show current position
    set ruler

    " Height of the command bar
    set cmdheight=1

    " A buffer becomes hidden when it is abandoned
    set hid

    " Configure backspace so it acts as it should act
    set backspace=eol,start,indent
    set whichwrap+=<,>,h,l

    " Ignore case when searching
    set ignorecase

    " When searching try to be smart about cases
    set smartcase

    " Highlight search results
    set hlsearch

    " Makes search act like search in modern browsers
    set incsearch

    " Don't redraw while executing macros (good performance config)
    set lazyredraw

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
    set background=dark
    colorscheme molokai_custom
    "let g:molokai_original = 0
    " Other popular colors
    " colorscheme monokai-phoenix

    " Set extra options when running in GUI mode
    if has("gui_running")
        set guioptions-=T
        set guioptions+=e
        set t_Co=256
        set guitablabel=%M\ %t
    endif

    " Set utf8 as standard encoding and en_US as the standard language
    set encoding=utf8

    " Use Unix as the standard file type
    set ffs=unix,dos,mac

    " Setting syntax for Jenkinsfile
    au BufNewFile,BufRead Jenkinsfile setf groovy " < activate it with Jenkinsfile

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => Files, backups and undo
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Turn backup off, since most stuff is in SVN, git et.c anyway...
    set nobackup
    set nowb
    set noswapfile

    " Put plugins and dictionaries in this dir (also on Windows)
    let vimDir = '$HOME/.vim'
    let &runtimepath.=','.vimDir

    " Keep undo history across sessions by storing it in a file
    if has('persistent_undo')
        let myUndoDir = expand(vimDir . '/undodir')
        " Create dirs
        call system('mkdir ' . vimDir)
        call system('mkdir ' . myUndoDir)
        let &undodir = myUndoDir
    set undofile
    endif

    " Ensure if vim is opened without params the last buffer is opened
    if argc() == 0
        autocmd VimEnter * nested :edit #<1
    endif

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
        autocmd BufRead *.go set nolist
    augroup END
    
    set ai "Auto indent
    set si "Smart indent
    set wrap "Wrap lines
    " set nowrap "I don't want wrapping

    " Fix for yaml file
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType yml setlocal ts=2 sts=2 sw=2 expandtab
    

    """"""""""""""""""""""""""""""
    " => Visual mode related
    """"""""""""""""""""""""""""""
    " Visual mode pressing * or # searches for the current selection
    " Super useful! From an idea by Michael Naumann
    vnoremap <silent> * :call VisualSelection('f')<CR>
    vnoremap <silent> # :call VisualSelection('b')<CR>


    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => Moving around, tabs, windows and buffers
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Treat long lines as break lines (useful when moving around in them)
    map j gj
    map k gk

    " Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
    map <space> /
    map <c-space> ?

    " Disable highlight when <leader><cr> is pressed
    map <silent> <leader><cr> :noh<cr>

    " Smart way to move between windows
    map <C-j> <C-W>j
    map <C-k> <C-W>k
    map <C-h> <C-W>h
    map <C-l> <C-W>l

    " Close the current buffer
    map <leader>bd :Bclose<cr>

    " Close all the buffers
    map <leader>ba :1,1000 bd!<cr>

    " Move to next and previous buffer
    map <tab> :bn<cr><cr>
    map <S-tab> :bp<cr>
    map <C-q> :Bclose<cr>

    " Useful mappings for managing tabs
    map <leader>tn :tabnew<cr>
    map <leader>to :tabonly<cr>
    map <leader>tc :tabclose<cr>
    map <leader>tm :tabmove

    " Opens a new tab with the current buffer's path
    " Super useful when editing files in the same directory
    map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

    " Switch CWD to the directory of the open buffer
    map <leader>cd :cd %:p:h<cr>:pwd<cr>

    " Specify the behavior when switching between buffers
    try
      set switchbuf=useopen,usetab,newtab
      set stal=2
    catch
    endtry

    " Return to last edit position when opening files (You want this!)
    autocmd BufReadPost *
         \ if line("'\"") > 0 && line("'\"") <= line("$") |
         \   exe "normal! g`\"" |
         \ endif
    " Remember info about open buffers on close
    set viminfo^=%

    " Open the definition in a new split window
    map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

    " Resize the window with bindings
    noremap <S-H> <C-W>5<
    noremap <S-L> <C-W>5>
    noremap <S-J> <C-W>2+
    noremap <S-K> <C-W>2-


    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => Editing mappings
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Remap VIM 0 to first non-blank character
    map 0 ^

    " Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
    "map <C-j> :move +1<CR>
    "map <C-k> :move -2<CR>

    if has("mac") || has("macunix")
      nmap <D-j> <M-j>
      nmap <D-k> <M-k>
      vmap <D-j> <M-j>
      vmap <D-k> <M-k>
    endif

    " Delete trailing white space on save, useful for Python and CoffeeScript ;)
    " Deactivating as this is not good for maintaining projects, as it affects files
    " func! DeleteTrailingWS()
    "   exe "normal mz"
    "   %s/\s\+$//ge
    "   exe "normal `z"
    " endfunc
    " autocmd BufWrite *.py :call DeleteTrailingWS()
    " autocmd BufWrite *.coffee :call DeleteTrailingWS()


    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => Spell checking
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Pressing ,ss will toggle and untoggle spell checking
    map <leader>ss :setlocal spell!<cr>

    " Quick Docs on spllcheck
    " Next spell word - ]s
    " Previous spell word - [s
    " Add word to dictionary - zg
    " Remove word from dicationary - z=

    set spelllang=en_gb
    set spellfile=$HOME/.vim/spell/en.utf-8.add
        
    augroup markdownSpell
        autocmd!
        autocmd FileType latex,tex,md,markdown setlocal spell
    augroup END

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    " => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scripbble
map <leader>q :e ~/buffer<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Set mouseclick for vimpp
set mouse=a

" Close with W and Q
command! -bang -range=% -complete=file -nargs=* W <line1>,<line2>write<bang> <args>
command! -bang Q quit<bang>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction


    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => Color syntax for NERDTree highlighting
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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


    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Configuration for extra visualisation in FZF.vim
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Command for git grep
    " - fzf#vim#grep(command, with_column, [options], [fullscreen])
    " command! -bang -nargs=* GGrep
    "  \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, <bang>0)
    "
    command! -bang -nargs=* GGrep
      \ call fzf#vim#grep(
      \   'git grep --line-number '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview(),
      \   <bang>0)

    " Override Colors command. You can safely do this in your .vimrc as fzf.vim
    " will not override existing commands.
    command! -bang Colors
      \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}, <bang>0)

    " Augmenting Ag command using fzf#vim#with_preview function
    "     * For syntax-highlighting, Ruby and any of the following tools are required:
    "       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
    "       - CodeRay: http://coderay.rubychan.de/
    "       - Rouge: https://github.com/jneen/rouge
    command! -bang -nargs=* Ag
      \ call fzf#vim#ag(<q-args>,
      \                 <bang>0 ? fzf#vim#with_preview({'options': '-i --delimiter : --nth 4..'}, 'up:60%')
      \                         : fzf#vim#with_preview({'options': '-i --delimiter : --nth 4..'}),
      \                 <bang>0)

    " Likewise, Files command with preview window
    command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

    " Likewise, GFiles command with preview window
    command! -bang -nargs=? -complete=dir GFiles
      \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)

    function! s:tags_sink(line)
      let parts = split(a:line, '\t\zs')
      let excmd = matchstr(parts[2:], '^.*\ze;"\t')
      execute 'silent e' parts[1][:-2]
      let [magic, &magic] = [&magic, 0]
      execute excmd
      let &magic = magic
    endfunction

    function! s:tags()
      if empty(tagfiles())
        echohl WarningMsg
        echom 'Preparing tags'
        echohl None
        call system('ctags -R')
      endif

      call fzf#run({
      \ 'source':  'cat '.join(map(tagfiles(), 'fnamemodify(v:val, ":S")')).
      \            '| grep -v -a ^!',
      \ 'options': '+m -d "\t" --with-nth 1,4,2,3.. -n 1 --tiebreak=index',
      \ 'down':    '40%',
      \ 'sink':    function('s:tags_sink')})
    endfunction

    command! Tags call fzf#vim#tags(expand('<cword>'), {'options': '--exact --select-1'})

    " " Reload vimrc file automatically
    " augroup myvimrc
    "     au!
    "     au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYVIMRC | endif
    " augroup END
     
    " Set reload vimrc 
    noremap <S-R> :source $MYVIMRC<CR>

    " Set Scroll
    set scrolloff=3
    " Add space between end of file
    " nnoremap j jzz
    " nnoremap k kzz
    nnoremap <C-d> <C-d>zz
    nnoremap <C-u> <C-u>zz


