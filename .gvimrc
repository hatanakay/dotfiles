" OS 別の設定 {{{

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
      set guifontwide=Ricty:h13
      set noimdisableactivate
      map ¥ <leader>
    endif
  endif
  if has('gui_gtk2')
    " set guifont=Monospace\\ 11
    set gfn=Takaoゴシック\ 11
  endif

" }}}

" GVim 固有の設定 {{{

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

" }}}


" 重複設定 {{{

  colorscheme molokai
  highlight WhitespaceEOL ctermbg=red guibg=red
  match WhitespaceEOL /\s\+$/
  autocmd WinEnter * match WhitespaceEOL /\s\+$/

" カレントウィンドウにのみ罫線を引く
augroup cch
autocmd! cch
autocmd WinLeave * set nocursorline
autocmd WinEnter,BufRead * set cursorline
augroup END
 
hi clear CursorLine
hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black

" }}}
