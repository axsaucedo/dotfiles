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
