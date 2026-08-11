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
