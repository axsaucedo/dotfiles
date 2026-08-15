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

    " Window movement on <C-hjkl> is owned by vim-tmux-navigator (see
    " plugins.lua) so it also crosses tmux panes; these old maps clobbered it
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
    " Window resize on Shift-hjkl (and Shift-arrows). Deliberately shadows
    " the native H/L (screen top/bottom) and J (join lines — use :join)
    noremap H <C-W>5<
    noremap L <C-W>5>
    noremap J <C-W>2+
    noremap K <C-W>2-
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
