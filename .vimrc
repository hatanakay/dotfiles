"---------------------------------------------------------------------------
" .vimrc
" 
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

"---------------------------------------------------------------------------
" 表示に関する設定:
"---------------------------------------------------------------------------
set title
" 行番号を表示
set number
" ルーラーを表示
set ruler
"入力中のコマンドをステータスに表示する
set showcmd
" 括弧入力時の対応する括弧を表示
set showmatch
" タブや改行を表示
set list
set listchars=eol:$,tab:>-
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

"---------------------------------------------------------------------------
"neobundle
"---------------------------------------------------------------------------
source ~/.vimrc.bundle


"---------------------------------------------------------------------------
" colorscheme
"---------------------------------------------------------------------------
colorscheme molokai
hi Visual ctermbg=19
let g:molokai_original = 1
let g:Powerline_theme = 'dark'
let g:Powerline_symbols = 'fancy'
let g:Powerline_colorscheme = 'molokai'
let g:Powerline_symbols = 'compatible'
let g:airline_theme = 'dark'
let g:Powerline_symbols='fancy'
"---------------------------------------------------------------------------
" 補完関連: neocomplcache neosnippet
"---------------------------------------------------------------------------

let g:neocomplcache_enable_at_startup            = 1
let g:neocomplcache_enable_smart_case            = 1 " Use smartcase.
let g:neocomplcache_enable_camel_case_completion = 1 " Use camel case completion.
let g:neocomplcache_enable_underbar_completion   = 1 " Use underbar completion.
let g:neocomplcache_min_syntax_length            = 3 " Set minimum syntax keyword length.
let g:neocomplcache_lock_buffer_name_pattern     = '\*ku\*'
let g:neocomplcache_text_mode_filetypes = {'text': 1, 'javascript': 1, 'markdown': 1, 'perl': 1, 'html': 1, 'ruby': 1}

"autocmd FileType python     setlocal omnifunc=pythoncomplete#Complete
autocmd FileType c             setlocal omnifunc=ccomplete#Complete
autocmd FileType css           setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript    setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType php           setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType python        setlocal omnifunc=pythoncomplete#Complete
autocmd FileType ruby          setlocal omnifunc=rubycomplete#Complete
autocmd FileType xml           setlocal omnifunc=xmlcomplete#CompleteTags

" RSense
let g:rsenseUseOmniFunc = 1
if filereadable(expand('/usr/local/bin/rsense'))
    let g:rsenseHome = expand('/usr/local/Cellar/rsense/0.3/libexec')

    " let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
endif

if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'c' : $HOME.'/.vim/dict/c.dict',
    \ 'cpp' : $HOME.'/.vim/dict/cpp.dict',
    \ 'javascript' : $HOME.'/.vim/dict/javascript.dict',
    \ 'perl' : $HOME.'/.vim/dict/perl.dict',
    \ 'php' : $HOME.'/.vim/dict/php.dict',
    \ 'vm' : $HOME.'/.vim/dict/vim.dict'
    \ }

" ユーザー定義スニペット保存ディレクトリ
let g:neocomplcache_snippets_dir = $HOME.'/.vim/snippets'

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif

let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
    set conceallevel=2 concealcursor=i
endif

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/snippets'

set wildmenu               " コマンド補完を強化
set wildchar=<tab>         " コマンド補完を開始するキー
set wildmode=list:full     " リスト表示，最長マッチ
set history=1000           " コマンド・検索パターンの履歴数
set complete+=k            " 補完に辞書ファイル追加

" Ex-modeでの<C-p><C-n>をzshのヒストリ補完っぽくする
cnoremap <C-p> <Up>
cnoremap <Up>  <C-p>
cnoremap <C-n> <Down>
cnoremap <Down>  <C-n>

highlight Pmenu ctermbg=233
highlight PmenuSel ctermbg=1
highlight PMenuSbar ctermbg=4
highlight String ctermfg=brown guifg=Orange cterm=none gui=none
highlight MatchParen guifg=Yellow guibg=darkgray
highlight SignColumn guibg=#101020

" カレント行ハイライトON
set cursorline
" アンダーラインを引く(color terminal)
highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
" アンダーラインを引く(gui)
highlight CursorLine gui=underline guifg=NONE guibg=NONE
"---------------------------------------------------------------------------
" quick run
"---------------------------------------------------------------------------
"vim markdown
let g:quickrun_config = {}
let g:quickrun_config['markdown'] = {
\ 'command': 'redcarpet',
\ 'outputter': 'browser',
\ 'cmdopt': '--parse-tables'
\ }

"---------------------------------------------------------------------------
" clipbord
"---------------------------------------------------------------------------
set clipboard+=unnamed
set pastetoggle=<c-e>
autocmd InsertLeave * set nopaste

"---------------------------------------------------------------------------
"Unite.vim
"---------------------------------------------------------------------------
" insert modeで開始
let g:unite_enable_start_insert = 1
" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1
let g:unite_enable_start_insert=1
" grep検索
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
" カーソル位置の単語をgrep検索
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
" grep検索結果の再呼出
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>
" バッファ一覧
nnoremap <silent> ,b :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,m :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,u :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,a :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
" colorscheme
nnoremap <silent> ,c :<C-u>Unite colorscheme<CR>
" .git以下で絞り込み
nnoremap <silent> ,e  :<C-u>Unite file_rec/async:!<CR>
" 現在のバッファを検索
nnoremap <silent> ,l  :<C-u>Unite line<CR>


" unite grep に ag(The Silver Searcher) を使う
"
let g:unite_source_grep_default_opts = '-Hn --color=never'
if executable('sg')
    let g:unite_source_grep_command = 'sg'
    let g:unite_source_grep_default_opts = '-i --nocolor --nogroup'
    let g:unite_source_grep_recursive_opt = ''
    let g:unite_source_grep_max_candidates = 200
elseif executable('ack-grep') || (has('mac') && executable('ack'))
    let g:unite_source_grep_command = 'ack-grep'
    let g:unite_source_grep_default_opts = '-i --no-heading --no-color -a'
endif

augroup Shebang
  autocmd BufNewFile *.py 0put =\"#!/usr/bin/env python\<nl># -*- coding: utf-8 -*-\<nl>\"|$
  autocmd BufNewFile *.rb 0put =\"#!/usr/bin/env ruby\<nl># -*- coding: utf-8 -*-\<nl>\"|$
  autocmd BufNewFile *.sh 0put =\"#!/bin/bash\<nl>\"
  autocmd BufNewFile *.tex 0put =\"%&plain\<nl>\"|$
  autocmd BufNewFile *.\(cc\|hh\) 0put =\"//\<nl>// \".expand(\"<afile>:t\").\" -- \<nl>//\<nl>\"|2|start!
augroup END


"---------------------------------------------------------------------------
" GNU GLOBAL gtags.vim
"---------------------------------------------------------------------------
" Gtags
" gtags
    " 検索結果Windowを閉じる
    nnoremap <C-q> <C-w><C-w><C-w>q
    " Grep 準備
    nnoremap <C-g> :Gtags -g
    " このファイルの関数一覧                                                                                                                                                
    nnoremap <C-l> :Gtags -f %<CR>
    " カーソル以下の定義元を探す
    nnoremap <C-j> :Gtags <C-r><C-w><CR>
    " カーソル以下の使用箇所を探す
    nnoremap <C-k> :Gtags -r <C-r><C-w><CR>
    " 次の検索結果
    nnoremap <C-n> :cn<CR>
    " 前の検索結果
    nnoremap <C-p> :cp<CR>

"---------------------------------------------------------------------------
" vim-startify
"---------------------------------------------------------------------------
"startify
    let g:startify_custom_header = [ 
                \ '     __  __                            ________     __ __      ',
                \ '    /\ \/\ \    __                    /\____   \   /\ \\ \     ',
                \ '    \ \ \ \ \  /\_\     ___ ___       \/___/  /    \ \ \\ \    ',
                \ '     \ \ \ \ \ \/\ \   / __` __`\         /  /      \ \ \\ \_  ',
                \ '      \ \ \_/ \ \ \ \ /\ \/\ \/\ \       /  /    __  \ \__  __\',
                \ '       \ `\___/  \ \_\\ \_\ \_\ \_\     /\_/    /\_\  \/_/\_\_/',
                \ '        `\/__/    \/_/ \/_/\/_/\/_/     \//     \/_/     \/_/  ',
                \ '',
                \ '',
                \ ]

    let g:startify_bookmarks = [ '~/.vimrc', '~/.vimrc.bundle', '~/.zshrc']

"---------------------------------------------------------------------------
" vimrc を楽に開く&& 再読み込み
"---------------------------------------------------------------------------
" open .vimrc
command! Ev edit $MYVIMRC
command! Rv source $MYVIMRC

" smartchr.vim
inoremap <expr> = smartchr#loop(' = ', ' == ', ' === ', '=')

"---------------------------------------------------------------------------
" vim-airline
"---------------------------------------------------------------------------
if has('multi_byte')
    let g:airline_powerline_fonts = 1
endif

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0

let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_branch_prefix = ' ⭠ '
let g:airline_readonly_symbol = ' ⭤ '
let g:airline_linecolumn_prefix = ' ⭡ '
let g:airline_paste_symbol = 'ρ'

"---------------------------------------------------------------------------
" memolist
"---------------------------------------------------------------------------
let g:memolist_path = "~/Dropbox/memo"
nnoremap <silent> ,mn :<C-u>MemoNew<CR>
nnoremap <silent> ,ml :<C-u>Unite file:<C-r>=expand(g:memolist_path."/")<CR><CR>
nnoremap <silent> ,mg :<C-u>Unite grep:<C-r>=expand(g:memolist_path."/")<CR><CR>
nnoremap <silent> ,mf :<C-u>VimFiler <C-r>=expand(g:memolist_path."/")<CR><CR>

"---------------------------------------------------------------------------
" gocode
"---------------------------------------------------------------------------
set rtp+=$GOROOT/misc/vim
"golint
exe "set rtp+=" . globpath($GOPATH, "/usr/local/opt/go/misc/vim")
