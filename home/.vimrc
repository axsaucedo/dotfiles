
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
        augroup vimrc_plug_bootstrap
            autocmd!
            autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
        augroup END
    endif

    " Setup vim-plug
    call plug#begin('~/.vim/plugged')

    " Enable plugins
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    " Nerd tree side directory
    Plug 'scrooloose/nerdtree'
    " NERDTree git plugin
    Plug 'Xuyuanp/nerdtree-git-plugin'
    " fuzzy search
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    " Colour parentheses
    Plug 'luochen1990/rainbow'
    " Multiple cursors
    Plug 'mg979/vim-visual-multi'
    " Navigation between tmux and vim
    Plug 'christoomey/vim-tmux-navigator'
    " Fugitive plugin
    Plug 'tpope/vim-fugitive'
    " NERD Commenter
    Plug 'scrooloose/nerdcommenter'
    " Bulletpoint plug
    Plug 'dkarter/bullets.vim'
    " COC Autocompllete
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Vim airline status line
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " Tokynight theme
    Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
    Plug 'loctvl842/monokai-pro.nvim'
    " Vim Repeat
    Plug 'tpope/vim-repeat'
    " Vim Easyclip (Disable if mac)
    "Plug 'svermeulen/vim-easyclip'
    " Avoid copying on every cut operation instead cut with mm
    Plug 'svermeulen/vim-cutlass'
    " Syntax for headlines
    Plug 'lukas-reineke/headlines.nvim'
    " Vim Markdown
    Plug 'godlygeek/tabular'
    Plug 'preservim/vim-markdown'
    " We use Pandoc instead as more consistent syntax than above
    Plug 'vim-pandoc/vim-pandoc'
    Plug 'vim-pandoc/vim-pandoc-syntax'
    " Markdown preview
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
    " Vim Table Mode (Toggle with :TableModeToggle)
    "Plug 'dhruvasagar/vim-table-mode'
    " Dim inactive (First plugin is to listen to tmux events, other to dim)
    "Plug 'tmux-plugins/vim-tmux-focus-events'
    "Plug 'blueyed/vim-diminactive' " Linked to plugin above
    " Colour picker
    Plug 'KabbAmine/vCoolor.vim'
    " Add colours to hex
    Plug 'etdev/vim-hexcolor'
    "" Sidebar minimap
    "Plug 'wfxr/minimap.vim'
    " close tags
    Plug 'alvan/vim-closetag'
    " Shortcuts to add/remove quotes/brances on selection
    Plug 'tpope/vim-surround'
    " Multi-language syntax support
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    " Advanced syntax support for cpp
    Plug 'octol/vim-cpp-enhanced-highlight'
    " Search and replace
    Plug 'MagicDuck/grug-far.nvim'
    " Cmake syntax
    Plug 'pboettch/vim-cmake-syntax'
    " Show the current / previous function
    Plug 'nvim-treesitter/nvim-treesitter-context'
    " Animations 
    Plug 'axsaucedo/neovim-power-mode'
    Plug 'sphamba/smear-cursor.nvim'
    Plug 'rachartier/tiny-glimmer.nvim'
    " Machine-local plugins (untracked; e.g. work-internal plugins)
    if filereadable(expand('~/.vim/plug.local.vim'))
        source ~/.vim/plug.local.vim
    endif
    " Finishing plugin list
    call plug#end()

    lua vim.filetype.add({ extension = { mdx = 'markdown.mdx' } })

    " Tree-sitter syntax highlighting
    if !exists('g:treesitter_configured')
        lua require('nvim-treesitter.configs').setup({ensure_installed = {'python', 'go', 'cpp', 'c', 'lua', 'vim', 'vimdoc', 'javascript', 'typescript', 'json', 'yaml', 'bash', 'markdown', 'markdown_inline', 'cmake', 'html', 'css'}, highlight = {enable = true, disable = {'markdown', 'markdown_inline'}}, auto_install = true})
        let g:treesitter_configured = 1
    endif

    " Tree-sitter context
    if !exists('g:treesitter_context_configured')
        lua require('treesitter-context').setup({})
        let g:treesitter_context_configured = 1
    endif

    " Neovim Power Mode
    let g:power_mode_auto_enable = 1
    let g:power_mode_particle_preset = 'rightburst'
    let g:power_mode_particle_cancel_on_new = 1
    let g:power_mode_shake_mode = 'none'
    let g:power_mode_fire_wall_enabled = 0
    let g:power_mode_combo_enabled = 1
    let g:power_mode_combo_position = 'top-right'
    let g:power_mode_color_1 = '#FF0000'
    let g:hud_linter_duration = 2

    " Initialising smear cursor
    lua require('smear_cursor').enabled = true
    " Initialised animations on copy tiny-glimmer
    if !exists('g:tiny_glimmer_configured')
        lua require('tiny-glimmer').setup({enabled = true})
        let g:tiny_glimmer_configured = 1
    endif

    " Machine-local plugin setup (untracked; pairs with ~/.vim/plug.local.vim)
    if filereadable(expand('~/.vimrc.local'))
        source ~/.vimrc.local
    endif

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
    if !exists('g:grug_far_configured')
        lua require('grug-far').setup({})
        let g:grug_far_configured = 1
    endif
    nnoremap <leader>fr :GrugFar<CR>

    " Airline status line
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#buffer_idx_mode = 1
    let g:airline_powerline_fonts = 1
    let g:airline_theme = "wombat"

    nmap <leader>1 <Plug>AirlineSelectTab1
    nmap <leader>2 <Plug>AirlineSelectTab2
    nmap <leader>3 <Plug>AirlineSelectTab3
    nmap <leader>4 <Plug>AirlineSelectTab4
    nmap <leader>5 <Plug>AirlineSelectTab5
    nmap <leader>6 <Plug>AirlineSelectTab6
    nmap <leader>7 <Plug>AirlineSelectTab7
    nmap <leader>8 <Plug>AirlineSelectTab8
    nmap <leader>9 <Plug>AirlineSelectTab9

    " Function that displays various different type of details form CoC.vim
    " syntax plugins based on language server
    function! ErrorsDiagnostic() abort
      let info = get(b:, 'coc_diagnostic_info', {})
      if empty(info) | return '' | endif
      let msgs = []
      if get(info, 'error', 0)
        call add(msgs, '💀' . info['error'] . ' ')
      endif
      return join(msgs, ' ')
    endfunction

    function! WarningsDiagnostic() abort
      let info = get(b:, 'coc_diagnostic_info', {})
      if empty(info) | return '' | endif
      let msgs = []
      if get(info, 'warning', 0)
        call add(msgs, ' ⚠️' . info['warning'] . '')
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
        let g:airline_section_a = airline#section#create(['😈 ', 'branch', '%{&paste?"📋✔":"📋⚪"}'])
        let g:airline_section_b = airline#section#create_left(['mode'])
        let g:airline_section_c = airline#section#create(['🔍 ', 'file'])
    endfunction
    augroup vimrc_airline
        autocmd!
        autocmd User AirlineAfterInit call AirlineInit()
    augroup END


    let g:airline#extensions#coc#enabled = 1

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


    " FZF
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " This function ensures that we use the relevant search depending on whether we
    "   are in a git repo or not
    fun! FzfOmniFiles()
        let is_git = system('git rev-parse --is-inside-work-tree 2>/dev/null')
        if v:shell_error
            :Files
        else
            :GFiles
        endif
    endfun
    noremap <C-p><C-p> :call FzfOmniFiles()<CR> 
    noremap <C-p><C-a> :Files<CR> 
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



    """"""""""""""""""""""""""""""
    " => Status line
    """"""""""""""""""""""""""""""
    " Always show the status line
    set laststatus=2

    " coc.nvim default settings
    " -------------------------------------------------------------------------------------------------
    "  Notes:
    "  High level:
    "  * Config file can be located at ~/.config/nvim/coc-settings.json
    "  * It can also be accessed through CocConfig
    "  * Currently integrated with airline statusline (errors/warnings & load)
    "
    "  Extensions are managed with :CocInstall / :CocUninstall; see the
    "  current set with :CocList extensions.
    "
    " CocGo config
    " - Ensure files are re-fromatted on save with imports (needed explicit as
    "   formatOnSaveFiletypes seems to only include format but not new imports)
    augroup vimrc_coc
        autocmd!
        autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
        autocmd CursorHold * silent call CocActionAsync('highlight')
    augroup END

    " TextEdit might fail if hidden is not set.
    set hidden

    " Some servers have issues with backup files, see #649.
    set nobackup
    set nowritebackup

    " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
    " delays and poor user experience.
    set updatetime=300

    " from error: 'redrawtime exceeded' below is suggested fix
    set redrawtime=10000
    set regexpengine=0

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
    "inoremap <silent><expr> <TAB>
    "  \ pumvisible() ? coc#_select_confirm() :
    "  \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
    "  \ <SID>check_back_space() ? "\<TAB>" :
    "  \ coc#refresh()
    "let g:coc_snippet_next = '<tab>' 
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
    nnoremap <M-i> :call CocActionAsync('highlight')<CR>

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
    "" Use <C-l> for trigger snippet expand.
    "imap <C-l> <Plug>(coc-snippets-expand)
    "" Use <C-j> for select text for visual placeholder of snippet.
    "vmap <C-j> <Plug>(coc-snippets-select)
    "" Use <C-j> for jump to next placeholder, it's default of coc.nvim
    "let g:coc_snippet_next = '<c-j>'
    "" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
    "let g:coc_snippet_prev = '<c-k>'
    "" Use <C-j> for both expand and jump (make expand higher priority.)
    "imap <C-j> <Plug>(coc-snippets-expand-jump)

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
    let g:cpp_class_scope_highlight = 1
    let g:cpp_member_variable_highlight = 1
    let g:cpp_class_decl_highlight = 1
    "let g:cpp_posix_standard = 1
    "let g:cpp_experimental_simple_template_highlight = 1
    "let g:cpp_experimental_template_highlight = 1
    augroup vimrc_cpp_filetype
        autocmd!
        autocmd BufRead,BufNewFile *.tpp set filetype=cpp
    augroup END


    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
    colorscheme molokai_custom
    "colorscheme molokai_dark
    let g:molokai_original = 1
    " Other popular colors
    " colorscheme monokai-phoenix
    set termguicolors " molokai_custom now carries true gui colors
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
    " <expr> keeps counts (5j) and operators (dj) on real lines; recursive
    " `map j gj` broke both.
    nnoremap <expr> j v:count ? 'j' : 'gj'
    nnoremap <expr> k v:count ? 'k' : 'gk'
    xnoremap <expr> j v:count ? 'j' : 'gj'
    xnoremap <expr> k v:count ? 'k' : 'gk'

    " Disable highlight when <leader><cr> is pressed
    map <silent> <leader><cr> :noh<cr>

    " Smart way to move between windows
    map <C-j> <C-W>j
    map <C-k> <C-W>k
    map <C-h> <C-W>h
    map <C-l> <C-W>l
    map <M-j> <C-W>j
    map <M-k> <C-W>k
    map <M-h> <C-W>h
    map <M-l> <C-W>l

    " Close the current buffer
    map <leader>bd :Bclose<cr>

    " Close all the buffers
    map <leader>ba :1,1000 bd!<cr>

    " Move to next and previous buffer
    nnoremap ]b :bn<cr>
    nnoremap [b :bp<cr>
    map <C-q> :Bclose<cr>


    " Close all buffers except current one
    map <C-e> :%bd<bar>e#<bar>bd#<cr>

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
    augroup vimrc_restore_cursor
        autocmd!
        autocmd BufReadPost *
             \ if line("'\"") > 0 && line("'\"") <= line("$") |
             \   exe "normal! g`\"" |
             \ endif
    augroup END
    " Remember info about open buffers on close
    set viminfo^=%

    " Open the definition in a new split window
    map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

    " Resize the window with bindings
    " Previously on <S-H/J/K/L>, which shadowed the native H/L (screen top/
    " bottom), J (join lines) and K — <S-J> IS J. Moved to Shift+arrows.
    noremap <S-Left> <C-W>5<
    noremap <S-Right> <C-W>5>
    noremap <S-Down> <C-W>2+
    noremap <S-Up> <C-W>2-


    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => Editing mappings
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
        " 'latex'/'md' are not real filetypes ('tex'/'markdown' are)
        autocmd FileType tex,plaintex,markdown setlocal spell
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

        let l:pattern = escape(@", '\/.*$^~[]')
        let l:pattern = substitute(l:pattern, "
$", "", "")

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
      let parts = split(a:line, '	\zs')
      let excmd = matchstr(parts[2:], '^.*\ze;"	')
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
      \ 'options': '+m -d "	" --with-nth 1,4,2,3.. -n 1 --tiebreak=index',
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
    noremap <leader>rv :source $MYVIMRC<CR>
    " Add space between end of file
    " nnoremap j jzz
    " nnoremap k kzz
    nnoremap <C-d> <C-d>zz
    nnoremap <C-u> <C-u>zz

    " Set new line to linux instead of windows
    set ff=unix
