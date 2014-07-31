"---------------------------------------------------------------------------
" 表示設定
"---------------------------------------------------------------------------
set antialias
if has('kaoriya')
    if has('win32')
        scriptencoding utf-8
        set guifont=Consolas:h11
        "set guifontwide=MS_Gothic
        let &guifontwide = iconv('Ricty:h10:cSHIFTJIS', &encoding, 'cp932')
        set ambiwidth=double
    endif
    if has('mac')
        set guifont=Ricty:h13
        set guifontwide=Ricty:h12
        set noimdisableactivate
        map ¥ <leader>
    endif
endif
if has('gui_gtk2')
    " set guifont=Monospace\\ 11
    set gfn=Takaoゴシック\ 11
endif

" disables toolbar and menu
set guioptions-=T
set guioptions-=m
" disables scroll bar
set guioptions-=r
set guioptions-=L

if has('gui_running')
    set background=light
else
    set background=dark
endif
set visualbell t_vb=
" ウインドウの幅
set columns=150
" ウインドウの高さ
set lines=50

"---------------------------------------------------------------------------
" colorscheme
"---------------------------------------------------------------------------
autocmd ColorScheme * highlight Identifier ctermfg=210
colorscheme molokai

let g:molokai_original = 1
let g:Powerline_theme = 'dark'
let g:Powerline_symbols = 'fancy'
let g:Powerline_colorscheme = 'molokai'
let g:Powerline_symbols = 'compatible'
let g:airline_theme = 'dark'
let g:Powerline_symbols='fancy'

"molokaiの内容を一部修正
hi Visual guibg=#0066ff
hi Normal ctermbg=0
highlight LineNr ctermfg=245 ctermbg=0
highlight CursorLineNr ctermfg=1 ctermbg=0
highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
hi Identifier ctermfg=120 ctermbg=0

"---------------------------------------------------------------------------
"CursorLine
"---------------------------------------------------------------------------
augroup cch
autocmd! cch
autocmd WinLeave * set nocursorline
autocmd WinEnter,BufRead * set cursorline
augroup END
 
hi clear CursorLine
hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black

