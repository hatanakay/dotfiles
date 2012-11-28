"---------------------------------------------------------------------------
" .vimrc
" 
"---------------------------------------------------------------------------
"neobundle
source ~/.vimrc.bundle
"---------------------------------------------------------------------------
" 編集に関する設定:
"
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

"---------------------------------------------------------------------------
" 表示に関する設定:
"
set title
" 行番号を表示
set number
" ルーラーを表示
set ruler
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
"
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
"
" バックアップファイルを作成しない
set nobackup
"---------------------------------------------------------------------------
"ステータスラインに文字コードと改行文字を表示する
" set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']['.&ft.']'}\ %F%=%l,%c%V%8P
if winwidth(0) >= 120
    set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %F%=[%{GetB()}]\ %l,%c%V%8P
else
    set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %f%=[%{GetB()}]\ %l,%c%V%8P
endif
"---------------------------------------------------------------------------
"vim markdown
let g:quickrun_config = {}
let g:quickrun_config['markdown'] = {
\ 'command': 'bluecloth',
\ 'exec': '%c -f %s'
\ }

"clipbord-----------------------------------------------------------------
set clipboard+=unnamed
set pastetoggle=<C-e>
"---------------------------------------------------------------------------
"powerline
let g:Powerline_symbols='fancy'
"---------------------------------------------------------------------------
"Unite.vim
" Unite.vim
let g:unite_enable_start_insert=1
" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
" colorscheme
nnoremap <silent> ,uc :<C-u>Unite colorscheme<CR>


augroup Shebang
  autocmd BufNewFile *.py 0put =\"#!/usr/bin/env python\<nl># -*- coding: utf-8 -*-\<nl>\"|$
  autocmd BufNewFile *.rb 0put =\"#!/usr/bin/env ruby\<nl># -*- coding: utf-8 -*-\<nl>\"|$
  autocmd BufNewFile *.tex 0put =\"%&plain\<nl>\"|$
  autocmd BufNewFile *.\(cc\|hh\) 0put =\"//\<nl>// \".expand(\"<afile>:t\").\" -- \<nl>//\<nl>\"|2|start!
augroup END

"---------------------------------------------------------------------------

      let g:neocomplcache_enable_at_startup            = 1
      let g:neocomplcache_enable_smart_case            = 1 " Use smartcase.
      let g:neocomplcache_enable_camel_case_completion = 1 " Use camel case completion.
      let g:neocomplcache_enable_underbar_completion   = 1 " Use underbar completion.
      let g:neocomplcache_min_syntax_length            = 3 " Set minimum syntax keyword length.
      let g:neocomplcache_lock_buffer_name_pattern     = '\*ku\*'
      let g:neocomplcache_text_mode_filetypes = {'text': 1, 'javascript': 1, 'markdown': 1, 'perl': 1, 'html': 1, 'ruby': 1}
      
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
"---------------------------------------------------------------------------

