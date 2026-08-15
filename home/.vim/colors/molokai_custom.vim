" Vim color file
"
" Author: Tomas Restrepo <tomas@winterdom.com>
" https://github.com/tomasr/molokai
"
" Note: Based on the Monokai theme for TextMate
" by Wimer Hazenberg and its darker variant
" by Hamish Stuart Macpherson
"

hi clear

if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="molokai"

if exists("g:molokai_original")
    let s:molokai_original = g:molokai_original
else
    let s:molokai_original = 0
endif


hi Boolean         guifg=#AE81FF
hi Character       guifg=#E6DB74
hi Number          guifg=#AE81FF
hi String          guifg=#E6DB74
hi Conditional     guifg=#F92672               gui=bold
hi Constant        guifg=#AE81FF               gui=bold
hi Cursor          guifg=#000000 guibg=#F8F8F0
hi iCursor         guifg=NONE guibg=NONE
hi Debug           guifg=#BCA3A3               gui=bold
hi Define          guifg=#66D9EF
hi Delimiter       guifg=#8F8F8F
hi DiffAdd                       guibg=#13354A
hi DiffChange      guifg=#89807D guibg=#4C4745
hi DiffDelete      guifg=#960050 guibg=#1E0010
hi DiffText                      guibg=#4C4745 gui=italic,bold

hi Directory       guifg=#A6E22E               gui=bold
hi Error           guifg=#E6DB74 guibg=#1E0010
hi ErrorMsg        guifg=#F92672 guibg=#232526 gui=bold
hi Exception       guifg=#A6E22E               gui=bold
hi Float           guifg=#AE81FF
hi FoldColumn      guifg=#465457 guibg=#000000
hi Folded          guifg=#465457 guibg=#000000
hi Function        guifg=#A6E22E
hi Identifier      guifg=#FD971F
hi Ignore          guifg=#808080 guibg=bg
hi IncSearch       guifg=#C4BE89 guibg=#000000

hi Keyword         guifg=#F92672               gui=bold
hi Label           guifg=#E6DB74               gui=none
hi Macro           guifg=#C4BE89               gui=italic
hi SpecialKey      guifg=#66D9EF               gui=italic

hi MatchParen      guifg=#000000 guibg=#FD971F gui=bold
hi ModeMsg         guifg=#E6DB74
hi MoreMsg         guifg=#E6DB74
hi Operator        guifg=#F92672

" auto-complete menu popup documentation
hi Pmenu           guifg=#d7ff00 guibg=#444444
hi PmenuSel                      guibg=#005f5f
hi PmenuSbar                     guibg=#005fff
hi PmenuThumb      guifg=#66D9EF

hi PreCondit       guifg=#A6E22E               gui=bold
hi PreProc         guifg=#A6E22E
hi Question        guifg=#66D9EF
hi Repeat          guifg=#F92672               gui=bold
hi Search          guifg=#000000 guibg=#FFE792
" marks
" NONE bg: blend with the (transparent) editor background instead of a
" distinct gray strip now that signcolumn is always visible
hi SignColumn      guifg=#A6E22E guibg=NONE
hi SpecialChar     guifg=#F92672               gui=bold
hi SpecialComment  guifg=#7E8E91               gui=bold
" guibg=bg would error once Normal guibg is NONE; NONE matches the old
" unset ctermbg anyway
hi Special         guifg=#66D9EF guibg=NONE    gui=italic
if has("spell")
    hi SpellBad    guisp=#FF0000 gui=undercurl
    hi SpellCap    guisp=#7070F0 gui=undercurl
    hi SpellLocal  guisp=#70F0F0 gui=undercurl
    hi SpellRare   guisp=#FFFFFF gui=undercurl
endif
hi Statement       guifg=#F92672               gui=bold
hi StatusLine      guifg=#455354 guibg=fg
hi StatusLineNC    guifg=#808080 guibg=#080808
hi StorageClass    guifg=#FD971F               gui=italic
hi Structure       guifg=#66D9EF
hi Tag             guifg=#F92672               gui=italic
hi Title           guifg=#ef5939
hi Todo            guifg=#FFFFFF guibg=bg      gui=bold

hi Typedef         guifg=#66D9EF
hi Type            guifg=#66D9EF               gui=none
hi Underlined      guifg=#808080               gui=underline

hi VertSplit       guifg=#808080 guibg=#080808 gui=bold
hi VisualNOS                     guibg=#403D3D
hi Visual                        guibg=#403D3D
hi WarningMsg      guifg=#FFFFFF guibg=#333333 gui=bold
hi WildMenu        guifg=#66D9EF guibg=#000000

hi TabLineFill     guifg=NONE guibg=NONE
hi TabLine         guibg=NONE guifg=NONE gui=none

if s:molokai_original == 1
   hi Normal          guifg=#F8F8F2 guibg=#272822
   hi Comment         guifg=#75715E
   hi CursorLine                    guibg=#3E3D32
   hi CursorLineNr    guifg=#FD971F               gui=none
   hi CursorColumn                  guibg=#3E3D32
   hi ColorColumn                   guibg=#3B3A32
   hi LineNr          guifg=#BCBCBC guibg=#3B3A32
   hi NonText         guifg=#75715E
   hi SpecialKey      guifg=#75715E
else
   hi Normal          guifg=#F8F8F2 guibg=#1B1D1E
   hi Comment         guifg=#7E8E91
   hi CursorLine                    guibg=#293739
   hi CursorLineNr    guifg=#FD971F               gui=none
   hi CursorColumn                  guibg=#293739
   hi ColorColumn                   guibg=#1c1c1c
   hi LineNr          guifg=#465457 guibg=#232526
   hi NonText         guifg=#465457
   hi SpecialKey      guifg=#465457
end

"
" Support for 256-color terminal
"
if &t_Co > 255
   hi Boolean         ctermfg=135 guifg=#af5fff
   hi Character       ctermfg=144 guifg=#afaf87
   hi Number          ctermfg=135 guifg=#af5fff
   hi String          ctermfg=144 guifg=#afaf87
   hi Conditional     ctermfg=161               cterm=bold guifg=#d7005f gui=bold
   hi Constant        ctermfg=135               cterm=bold guifg=#af5fff gui=bold
   hi Cursor          ctermfg=16  ctermbg=253 guifg=#000000 guibg=#dadada
   hi Debug           ctermfg=225               cterm=bold guifg=#ffd7ff gui=bold
   hi Define          ctermfg=81 guifg=#5fd7ff
   hi Delimiter       ctermfg=241 guifg=#626262

   hi DiffAdd                     ctermbg=24 guibg=#005f87
   hi DiffChange      ctermfg=181 ctermbg=239 guifg=#d7afaf guibg=#4e4e4e
   hi DiffDelete      ctermfg=162 ctermbg=53 guifg=#d70087 guibg=#5f005f
   hi DiffText                    ctermbg=102 cterm=bold guibg=#878787 gui=bold

   hi Directory       ctermfg=118               cterm=bold guifg=#87ff00 gui=bold
   hi Error           ctermfg=219 ctermbg=89 guifg=#ffafff guibg=#87005f
   hi ErrorMsg        ctermfg=199 ctermbg=16    cterm=bold guifg=#ff00af guibg=#000000 gui=bold
   hi Exception       ctermfg=118               cterm=bold guifg=#87ff00 gui=bold
   hi Float           ctermfg=135 guifg=#af5fff
   hi FoldColumn      ctermfg=67  ctermbg=16 guifg=#5f87af guibg=#000000
   hi Folded          ctermfg=67  ctermbg=16 guifg=#5f87af guibg=#000000
   hi Function        ctermfg=118 guifg=#87ff00
   hi Identifier      ctermfg=208               cterm=none guifg=#ff8700 gui=none
   hi Ignore          ctermfg=244 ctermbg=232 guifg=#808080 guibg=#080808
   hi IncSearch       ctermfg=193 ctermbg=16 guifg=#d7ffaf guibg=#000000

   hi keyword         ctermfg=161               cterm=bold guifg=#d7005f gui=bold
   hi Label           ctermfg=229               cterm=none guifg=#ffffaf gui=none
   hi Macro           ctermfg=193 guifg=#d7ffaf
   hi SpecialKey      ctermfg=81 guifg=#5fd7ff

   hi MatchParen      ctermfg=233  ctermbg=208 cterm=bold guifg=#121212 guibg=#ff8700 gui=bold
   hi ModeMsg         ctermfg=229 guifg=#ffffaf
   hi MoreMsg         ctermfg=229 guifg=#ffffaf
   hi Operator        ctermfg=161 guifg=#d7005f

   " auto-complete menu popup documentation
   hi Pmenu           ctermfg=228 ctermbg=238 guifg=#ffff87 guibg=#444444
   hi PmenuSel        ctermfg=255 ctermbg=23 guifg=#eeeeee guibg=#005f5f
   hi PmenuSbar                   ctermbg=27 guibg=#005fff
   hi PmenuThumb      ctermfg=81 guifg=#5fd7ff

   hi PreCondit       ctermfg=118               cterm=bold guifg=#87ff00 gui=bold
   hi PreProc         ctermfg=118 guifg=#87ff00
   hi Question        ctermfg=81 guifg=#5fd7ff
   hi Repeat          ctermfg=161               cterm=bold guifg=#d7005f gui=bold
   hi Search          ctermfg=0   ctermbg=222   cterm=NONE guifg=#000000 guibg=#ffd787 gui=NONE

   " marks column
   hi SignColumn      ctermfg=118 ctermbg=NONE guifg=#87ff00 guibg=NONE
   hi SpecialChar     ctermfg=161               cterm=bold guifg=#d7005f gui=bold
   hi SpecialComment  ctermfg=245               cterm=bold guifg=#8a8a8a gui=bold
   hi Special         ctermfg=81 guifg=#5fd7ff
   if has("spell")
       hi SpellBad                ctermbg=52 guibg=#5f0000
       hi SpellCap                ctermbg=17 guibg=#00005f
       hi SpellLocal              ctermbg=17 guibg=#00005f
       hi SpellRare  ctermfg=none ctermbg=none  cterm=reverse gui=reverse
   endif
   hi Statement       ctermfg=161               cterm=bold guifg=#d7005f gui=bold
   hi StatusLine      ctermfg=238 ctermbg=253 guifg=#444444 guibg=#dadada
   hi StatusLineNC    ctermfg=244 ctermbg=232 guifg=#808080 guibg=#080808
   hi StorageClass    ctermfg=208 guifg=#ff8700
   hi Structure       ctermfg=81 guifg=#5fd7ff
   hi Tag             ctermfg=161 guifg=#d7005f
   hi Title           ctermfg=166 guifg=#d75f00
   hi Todo            ctermfg=231 ctermbg=232   cterm=bold guifg=#ffffff guibg=#080808 gui=bold

   hi Typedef         ctermfg=81 guifg=#5fd7ff
   hi Type            ctermfg=81                cterm=none guifg=#5fd7ff gui=none
   hi Underlined      ctermfg=244               cterm=underline guifg=#808080 gui=underline

   hi VertSplit       ctermfg=244 ctermbg=232   cterm=bold guifg=#808080 guibg=#080808 gui=bold
   hi VisualNOS                   ctermbg=238 guibg=#444444
   hi Visual                      ctermbg=235 guibg=#262626
   hi WarningMsg      ctermfg=231 ctermbg=238   cterm=bold guifg=#ffffff guibg=#444444 gui=bold
   hi WildMenu        ctermfg=81  ctermbg=16 guifg=#5fd7ff guibg=#000000

   hi Comment         ctermfg=59 guifg=#5f5f5f
   hi CursorColumn                ctermbg=234 guibg=#1c1c1c
   hi CursorLine                  ctermbg=234 cterm=none guibg=#1c1c1c gui=none
   hi ColorColumn                 ctermbg=234 guibg=#1c1c1c
   hi CursorLineNr    ctermfg=208 cterm=none guifg=#ff8700 gui=none
   hi LineNr          ctermfg=250 ctermbg=238 guifg=#bcbcbc guibg=#444444
   hi NonText         ctermfg=59 guifg=#5f5f5f
   hi Normal          ctermfg=252 ctermbg=233 guifg=#d0d0d0 guibg=#121212

   hi SpecialKey      ctermfg=59 guifg=#5f5f5f

   if exists("g:rehash256") && g:rehash256 == 1
       hi Normal       ctermfg=252 ctermbg=234 guifg=#d0d0d0 guibg=#1c1c1c
       hi CursorLine               ctermbg=233   cterm=none guibg=#121212 gui=none
       hi CursorLineNr ctermfg=208               cterm=none guifg=#ff8700 gui=none

       hi Boolean         ctermfg=141 guifg=#af87ff
       hi Character       ctermfg=222 guifg=#ffd787
       hi Number          ctermfg=141 guifg=#af87ff
       hi String          ctermfg=222 guifg=#ffd787
       hi Conditional     ctermfg=197               cterm=bold guifg=#ff005f gui=bold
       hi Constant        ctermfg=141               cterm=bold guifg=#af87ff gui=bold

       hi DiffDelete      ctermfg=125 ctermbg=233 guifg=#af005f guibg=#121212

       hi Directory       ctermfg=154               cterm=bold guifg=#afff00 gui=bold
       hi Error           ctermfg=222 ctermbg=233 guifg=#ffd787 guibg=#121212
       hi Exception       ctermfg=154               cterm=bold guifg=#afff00 gui=bold
       hi Float           ctermfg=141 guifg=#af87ff
       hi Function        ctermfg=154 guifg=#afff00
       hi Identifier      ctermfg=208 guifg=#ff8700

       hi Keyword         ctermfg=197               cterm=bold guifg=#ff005f gui=bold
       hi Operator        ctermfg=197 guifg=#ff005f
       hi PreCondit       ctermfg=154               cterm=bold guifg=#afff00 gui=bold
       hi PreProc         ctermfg=154 guifg=#afff00
       hi Repeat          ctermfg=197               cterm=bold guifg=#ff005f gui=bold

       hi Statement       ctermfg=197               cterm=bold guifg=#ff005f gui=bold
       hi Tag             ctermfg=197 guifg=#ff005f
       hi Title           ctermfg=203 guifg=#ff5f5f
       hi Visual                      ctermbg=238 guibg=#444444

       hi Comment         ctermfg=244 guifg=#808080
       hi LineNr          ctermfg=239 ctermbg=235 guifg=#4e4e4e guibg=#262626
       hi NonText         ctermfg=239 guifg=#4e4e4e
       hi SpecialKey      ctermfg=239 guifg=#4e4e4e
   endif
end

" Setting ctermbg as NONE to ensure parent background is used
" NONE on both sides: text and background come from the terminal profile,
" keeping the background transparent exactly as the 256-colour config did
hi Normal           guifg=NONE guibg=NONE ctermfg=none gui=none ctermbg=NONE
hi Function ctermfg=81 guifg=#5fd7ff
hi Exception       ctermfg=197 cterm=bold guifg=#ff005f gui=bold
hi String ctermfg=228 guifg=#ffff87
hi Comment         ctermfg=244 cterm=bold guifg=#808080 gui=bold
hi Visual                      ctermbg=238 guibg=#444444
hi Highlight                   cterm=bold ctermbg=Blue ctermfg=NONE guifg=NONE guibg=#0000bb gui=bold
hi Search          ctermbg=210 ctermfg=black guifg=#000000 guibg=#ff8787
hi IncSearch          ctermfg=210 ctermbg=black guifg=#ff8787 guibg=#000000
set cursorline
set cursorcolumn
hi Cursor          guifg=NONE guibg=#dadada ctermfg=NONE  ctermbg=253
hi PreCondit       ctermfg=197 cterm=bold guifg=#ff005f gui=bold
hi Directory       ctermfg=81 cterm=bold guifg=#5fd7ff gui=bold
hi PreProc         ctermfg=197 guifg=#ff005f
hi StatusLine      ctermfg=231 ctermbg=232 guifg=#ffffff guibg=#080808
hi StatusLineNC    ctermfg=244 ctermbg=232 guifg=#808080 guibg=#080808

" Custom CoCVIM settings
hi CocErrorHighlight ctermbg=52  guibg=#5f0000
"hi CocWarningHighlight ctermbg=3  guibg=#808000
"hi CocInfoHighlight ctermfg=Red  guifg=#ff0000
"hi CocHintHighlight ctermfg=Red  guifg=#ff0000
"hi CocErrorLine ctermbg=52  guibg=#5f0000
"hi CocWarningLine ctermbg=3  guibg=#808000
"hi CocInfoLine ctermfg=Red  guifg=#ff0000
"hi CocHintLine ctermfg=Red  guifg=#ff0000

hi CocHighlightText guibg=#00005f ctermbg=17 gui=underline cterm=underline

" Must be at the end, because of ctermbg=234 bug.
" https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
set background=dark

