"---------------------------------------------------------------------------
" 編集に関する設定:
"---------------------------------------------------------------------------
" タブの画面上での幅
set tabstop=4
" タブをスペースに展開
set expandtab
" オートインデント
set cindent
set smartindent
" オートインデントの深さ
set shiftwidth=4
" バックスペースでインデントや改行を削除
set backspace=indent,eol,start
" コンマの後に自動的にスペースを挿入
inoremap , ,<Space>
"  Insert mode中で単語単位/行単位の削除をアンドゥ可能にする
inoremap <C-u>  <C-g>u<C-u>
inoremap <C-w>  <C-g>u<C-w>
au FileType ruby set ts=2 sw=2 expandtab
au FileType php  set ts=4 sw=4 expandtab
"syntax Hilight
syntax on
filetype on
filetype indent on
filetype plugin on
" EmacsのC-oと同じ動作
nnoremap go :<C-u>call append('.', '')<CR>
" ↑の逆バージョン
nnoremap gO :normal! O<ESC>j
"Ctrl-a Ctrl-x で常に10進として扱う
set nf=""
"p レジスタ0を
vnoremap p "0P
"貼り付けたテキストを素早く選択する
noremap gV `[v`]
"不要なウィンドウのポップアップを抑制する
map q: :q

"---------------------------------------------------------------------------
" 表示に関する設定:
"---------------------------------------------------------------------------
autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
set title
" 行番号を表示
set number
" 東アジアの文字で文脈によって文字幅が異なる文字の幅を指定する
set ambiwidth=double
" ルーラーを表示
set ruler
"入力中のコマンドをステータスに表示する
set showcmd
" 括弧入力時の対応する括弧を表示
set showmatch
" タブや改行を表示
set list
set listchars=tab:>-
" 折り返し表示しない
set nowrap
" 検索結果をハイライト
set hlsearch
" 括弧入力時に対応する括弧を表示
set showmatch
" ビジュアルベル
set visualbell
"ファイル名補完
set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
"全角スペース表示
highlight link ZenkakuSpace Error
match ZenkakuSpace /　/
" ターミナルタイプによるカラー設定
if &term =~ "xterm-256color" || "screen-256color"
  " 256色
  set t_Co=256
  set t_Sf=[3%dm
  set t_Sb=[4%dm
elseif &term =~ "xterm-debian" || &term =~ "xterm-xfree86"
  set t_Co=16
  set t_Sf=[3%dm
  set t_Sb=[4%dm
elseif &term =~ "xterm-color"
  set t_Co=8
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif
" カレント行ハイライトON
set cursorline
set nocursorcolumn
" アンダーラインを引く(color terminal)
highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
" アンダーラインを引く(gui)
highlight CursorLine gui=underline guifg=NONE guibg=NONE
"path展開
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

"---------------------------------------------------------------------------
" 検索の挙動に関する設定:
"---------------------------------------------------------------------------
" インクリメンタルサーチ
set incsearch
" 検索時に大文字小文字を無視
set ignorecase
" 検索時にファイルの最後まで行ったら最初へ
set wrapscan
" Esc連打で検索時にハイライトを消す
nmap <Esc><Esc> :nohlsearch<CR><Esc>

"---------------------------------------------------------------------------
" ファイル操作に関する設定:
"---------------------------------------------------------------------------
" バックアップファイルを作成しない
set nobackup
set noswapfile
set noundofile
" 指定のデータをレジスタに登録する
function! s:Clip(data)
  let @*=a:data
  echo "clipped: " . a:data
endfunction
" 現在開いているファイルのパスをレジスタへ
command! -nargs=0 ClipPath call s:Clip(expand('%:p'))
" 現在開いているファイルのファイル名をレジスタへ
command! -nargs=0 ClipFile call s:Clip(expand('%:t'))
" 現在開いているファイルのディレクトリパスをレジスタへ
command! -nargs=0 ClipDir  call s:Clip(expand('%:p:h'))
" pathをCopy
nnoremap <C-y> :ClipPath<CR>

"---------------------------------------------------------------------------
" clipbord
"---------------------------------------------------------------------------
set clipboard+=unnamed
"set clipboard+=autoselect
set pastetoggle=<c-e>
autocmd InsertLeave * set nopaste

augroup Shebang
  autocmd BufNewFile *.py 0put =\"#!/usr/bin/env python\<nl># -*- coding: utf-8 -*-\<nl>\"|$
  autocmd BufNewFile *.rb 0put =\"#!/usr/bin/env ruby\<nl># -*- coding: utf-8 -*-\<nl>\"|$
  autocmd BufNewFile *.sh 0put =\"#!/bin/bash\<nl>\"
  autocmd BufNewFile *.tex 0put =\"%&plain\<nl>\"|$
  autocmd BufNewFile *.\(cc\|hh\) 0put =\"//\<nl>// \".expand(\"<afile>:t\").\" -- \<nl>//\<nl>\"|2|start!
augroup END

"---------------------------------------------------------------------------
" vimrc を楽に開く&& 再読み込み
"---------------------------------------------------------------------------
" open .vimrc
command! Ev edit "~/.config/nvim/settings.vim"
command! Rv source "~/.config/nvim/init.vim"

"---------------------------------------------------------------------------
" golang
"---------------------------------------------------------------------------
autocmd FileType go autocmd BufWritePre <buffer> Fmt
set rtp^=$GOPATH/src/github.com/nsf/gocode/vim
if $GOROOT != ''
  set rtp+=$GOROOT/misc/vim
endif
let g:tagbar_type_go = {  
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }
let g:go_fmt_command = "goimports"

"---------------------------------------------------------------------------
" vim-tags
"---------------------------------------------------------------------------
let g:vim_tags_project_tags_command = "/usr/local/bin/ctags --tag-relative --recurse --sort=yes  --append=no -f tags --exclude=tmp  2>/dev/null"
let g:vim_tags_gems_tags_command = "/usr/local/bin/ctags -R -f Gemfile.lock.tags `bundle show --paths --sort=yes` 2>/dev/null"
set tags+=tags,Gemfile.lock.tags

"---------------------------------------------------------------------------
" TagBar
"---------------------------------------------------------------------------
nnoremap <silent> ,k :<C-u>TagbarToggle<CR>

"---------------------------------------------------------------------------
" easy motion
"---------------------------------------------------------------------------
let g:EasyMotion_do_mapping = 0 " Disable default mappings

nmap s <Plug>(easymotion-s)
nmap s <Plug>(easymotion-s2)

let g:EasyMotion_smartcase = 1

map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

"---------------------------------------------------------------------------
" Open Brower Github
"---------------------------------------------------------------------------
let g:openbrowser_github_always_used_branch='master'
:function! OpenWithVisual()
    call setpos("'<", getpos("."))
    call setpos("'>", getpos("."))
    normal! gv
    :'<,'>OpenGithubFile
:endfunction
command! Gh :call OpenWithVisual()
nnoremap <C-l> :call OpenWithVisual()<CR>

"---------------------------------------------------------------------------
" json
"---------------------------------------------------------------------------
let g:vim_json_syntax_conceal = 0

"---------------------------------------------------------------------------
" gitgutter
"---------------------------------------------------------------------------
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0



"---------------------------------------------------------------------------
" colorscheme
"---------------------------------------------------------------------------
autocmd ColorScheme * highlight Identifier ctermfg=210
colorscheme molokai
let g:molokai_original = 1

"molokaiの内容を一部修正
hi Visual ctermbg=19
hi Normal ctermbg=0
highlight LineNr ctermfg=245 ctermbg=0
highlight CursorLineNr ctermfg=1 ctermbg=0
highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
hi Identifier ctermfg=120 ctermbg=0

" 括弧を自動補完 (改造版)
inoremap {{ {}<LEFT>
inoremap [[ []<LEFT>
inoremap (( ()<LEFT>
inoremap "" ""<LEFT>
inoremap '' ''<LEFT>
vnoremap { "zdi^V{<C-R>z}<ESC>
vnoremap [ "zdi^V[<C-R>z]<ESC>
vnoremap ( "zdi^V(<C-R>z)<ESC>
vnoremap " "zdi^V"<C-R>z^V"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>
 
""---------------------------------------------------------------------------
" Open Brower Github
"---------------------------------------------------------------------------
let g:openbrowser_github_always_used_branch='master'
:function! OpenWithVisual()
    call setpos("'<", getpos("."))
    call setpos("'>", getpos("."))
    normal! gv
    :'<,'>OpenGithubFile
:endfunction
command! Gh :call OpenWithVisual()
nnoremap <C-l> :call OpenWithVisual()<CR>

"---------------------------------------------------------------------------
" vim-airline
"---------------------------------------------------------------------------
if has('multi_byte')
    let g:airline_powerline_fonts = 1
endif

let g:airline_theme = 'dark'
let g:airline#extensions#tabline#enabled  =  2
let g:airline#extensions#tabline#fnamemod  =  ':t'
let g:airline#extensions#tabline#left_sep  =  ' '
let g:airline#extensions#tabline#left_alt_sep  =  '|'
let g:airline#extensions#tabline#right_sep  =  ' '
let g:airline#extensions#tabline#right_alt_sep  =  '|'
let g:airline_left_sep  =  ' '
let g:airline_left_alt_sep  =  '|'
let g:airline_right_sep  =  ' '
let g:airline_right_alt_sep  =  '|'

"---------------------------------------------------------------------------
" json
"---------------------------------------------------------------------------
let g:vim_json_syntax_conceal = 0

"---------------------------------------------------------------------------
" gitgutter
"---------------------------------------------------------------------------
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

"---------------------------------------------------------------------------
" denite.nvim
"---------------------------------------------------------------------------
let g:python3_host_prog  = expand("/usr/local/bin/python3")
call denite#custom#source('file_rec', 'matcher', ['matcher_cpsm'])
call denite#custom#option('default', 'prompt', '>> :')
call denite#custom#option('default', 'vertical_preview', 1)
call denite#custom#option('default', 'short_source_names', 1)
call denite#custom#option('list', 'mode', 'normal')
call denite#custom#option('list', 'winheight', 12)

call denite#custom#var('grep', 'command', ['pt'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'final_opts', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'default_opts',
      \ ['--follow', '--nocolor', '--nogroup'])
call denite#custom#var('file_rec', 'command',
      \ ['pt', '--follow', '--nocolor', '--nogroup', ''])
call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command',
    \ ['git', 'ls-files', '-co', '--exclude-standard'])

nnoremap <silent> ,f :<C-u>Denite
    \ `finddir('.git', ';') != '' ? 'file_rec/git' : 'file_rec'`<CR>
nnoremap <silent> ,g   :<C-u>Denite grep<CR>
nnoremap <silent> ,cg  :<C-u>DeniteCursorWord grep<CR>
nnoremap <silent> ,l   :<C-u>Denite line<CR>
nnoremap <silent> ,b   :<C-u>Denite buffer<CR>
nnoremap <silent> ,d   :<C-u>Denite directory_rec -default-action=cd<CR>
nnoremap <silent> ,m   :<C-u>Denite file_mru<CR>
nnoremap <silent> ,y   :<C-u>Denite neoyank<CR>
nnoremap <silent> ,o   :<C-u>Denite outline<CR>
nnoremap <silent> ,r   :<C-u>Denite -resume<CR>
nnoremap <silent> ,j   :<C-u>Denite jump change file_point<CR>
nnoremap <silent> ,e   :<C-u>Denite ghq<CR>
nnoremap <silent> ,z   :<C-u>Denite z -default-action=cd<CR>

call denite#custom#map('insert', "<C-n>", '<denite:move_to_next_line>')
call denite#custom#map('insert', "<C-p>", '<denite:move_to_previous_line>')

