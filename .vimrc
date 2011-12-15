"---------------------------------------------------------------------------
"基本設定
set nocompatible "vi非互換モード
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis,cp932
set nowritebackup

"---------------------------------------------------------------------------
" 編集に関する設定:
"
" タブの画面上での幅
set tabstop=4
" タブをスペースに展開
set expandtab
" オートインデント
set cindent
" オートインデントの深さ
set shiftwidth=4
" バックスペースでインデントや改行を削除
set backspace=indent,eol,start

"---------------------------------------------------------------------------
" 表示に関する設定:
"
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
"モード表示
set showmode
"ファイル名表示
set title
"コマンドステータス表示
set showcmd
"
"---------------------------------------------------------------------------
" 検索の挙動に関する設定:
"
" インクリメンタルサーチ
set incsearch
" 検索時に大文字小文字を無視
set ignorecase
" 検索時にファイルの最後まで行ったら最初へ
set wrapscan

"---------------------------------------------------------------------------
" ファイル操作に関する設定:
"
" バックアップファイルを作成しない
set nobackup
set clipboard+=unnamed
"---------------------------------------------------------------------------
"プログラミング関連の設定:
"オートインデント
set smartinden


"For Ruby
syntax on
filetype on
filetype indent on
filetype plugin on

 Align.vim
 let g:Align_xstrlen=3

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
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer
file_mru bookmark file<CR>
" colorscheme
nnoremap <silent> ,uc :<C-u>Unite colorscheme<CR>

" Vim command completion
set wildmode=longest,list

"---------------------------------------------------------------------------

"neobundle
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle'))
endif

" 使いたいプラグインのリポジトリを羅列。Subversion とか Mercurial でもいけるらしい。
NeoBundle 'git://github.com/Shougo/neocomplcache.git'
NeoBundle 'git://github.com/Shougo/neobundle.vim.git'
NeoBundle 'git://github.com/Shougo/vimproc.git'
NeoBundle 'git://github.com/Shougo/unite.vim.git'
NeoBundle 'git://github.com/mattn/zencoding-vim.git'
NeoBundle 'git://github.com/thinca/vim-quickrun.git'
NeoBundle 'git://github.com/thinca/vim-ref.git'
NeoBundle 'git://github.com/tsaleh/vim-align.git'

