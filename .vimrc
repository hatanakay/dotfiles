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

"p レジスタ0を
vnoremap <silent> p "0p
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

nnoremap <C-y> :ClipPath<CR>

"---------------------------------------------------------------------------
" 移動 
"---------------------------------------------------------------------------
runtime macros/matchit.vim

"---------------------------------------------------------------------------
"neobundle
"---------------------------------------------------------------------------
source ~/.vimrc.bundle

"---------------------------------------------------------------------------
" dylib
"---------------------------------------------------------------------------
let s:lua_dir = system("brew --prefix lua")
let $LUA_DLL= s:lua_dir . "/lib/liblua.dylib"
"---------------------------------------------------------------------------
" ruby
"---------------------------------------------------------------------------
"if has('gui_macvim') && has('kaoriya')
  "let s:ruby_libdir = system("ruby -rrbconfig -e 'print RbConfig::CONFIG[\"libdir\"]'")
  "let s:ruby_libruby = s:ruby_libdir . '/libruby.dylib'
  "if filereadable(s:ruby_libruby)
    "let $RUBY_DLL = s:ruby_libruby
  "endif
"endif
" .や::を入力したときにオムニ補完が有効になるようにする
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

" 環境変数RSENSE_HOMEに'/usr/local/bin/rsense'を指定しても動く
let g:neocomplete#sources#rsense#home_directory = '/usr/local/bin/rsense'
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
hi Visual ctermbg=19
hi Normal ctermbg=0
highlight LineNr ctermfg=245 ctermbg=0
highlight CursorLineNr ctermfg=1 ctermbg=0
highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
hi Identifier ctermfg=120 ctermbg=0

"---------------------------------------------------------------------------
" 補完関連: neocomplcache neosnippet
"---------------------------------------------------------------------------
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

let g:neocomplcache_enable_at_startup            = 1
let g:neocomplcache_enable_smart_case            = 1 " Use smartcase.
let g:neocomplcache_enable_camel_case_completion = 1 " Use camel case completion.
let g:neocomplcache_enable_underbar_completion   = 1 " Use underbar completion.
let g:neocomplcache_min_syntax_length            = 3 " Set minimum syntax keyword length.
let g:neocomplcache_lock_buffer_name_pattern     = '\*ku\*'
let g:neocomplcache_text_mode_filetypes = {'text': 1, 'javascript': 1, 'markdown': 1, 'perl': 1, 'html': 1, 'ruby': 1}

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

let g:neosnippet#snippets_directory =
          \'~/.vim/bundle/neosnippet-snippets/neosnippets'

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

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
 
"---------------------------------------------------------------------------
" quick run
"---------------------------------------------------------------------------
"vim markdown
let g:quickrun_config = {}
let g:quickrun_config.markdown = {
      \ 'outputter' : 'null',
      \ 'command'   : 'open',
      \ 'cmdopt'    : '-a',
      \ 'args'      : 'Marked',
      \ 'exec'      : '%c %o %a %s',
      \ }
"---------------------------------------------------------------------------
" clipbord
"---------------------------------------------------------------------------
set clipboard+=unnamed
set clipboard+=autoselect
set pastetoggle=<c-e>
autocmd InsertLeave * set nopaste

"---------------------------------------------------------------------------
"Unite.vim
"---------------------------------------------------------------------------

let g:unite_source_ruby_require_ruby_command = expand("~/.rbenv/shims/ruby")
let g:unite_data_directory='~/.vim/bundle/unite.vim'
"インサートモードで開始しない
let g:unite_enable_start_insert = 0
"file_mruの表示フォーマットを指定。空にすると表示スピードが高速化される
let g:unite_source_file_mru_filename_format = ''

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
nnoremap <silent> ,a :<C-u>UniteWithCurrentDir -buffer-name=files buffer file_mru bookmark file<CR>
" .git以下で絞り込み
if isdirectory(getcwd()."/.git")
    nnoremap <silent> ,e  :<C-u>Unite file_rec/git<CR>
else
    nnoremap <silent> ,e  :<C-u>Unite file_rec/async:!<CR>
endif
" 現在のバッファを検索
nnoremap <silent> ,l  :<C-u>Unite line<CR>
" outline
nnoremap <silent> ,o  :<C-u>Unite outline<CR>
" tags一覧
nnoremap <silent> ,t :<C-u>Unite -buffer-name=tags tag<CR>
"nnoremap <silent> ,y :<C-u>Unite history/yank<CR>
nnoremap <silent>,s :<C-u>Unite ghq<CR>
"vimfilerで最近使ったディレクトリへ移動
nnoremap <silent>,d :<C-u>Unite -buffer-name=files -default-action=lcd directory_mru<CR>

" unite grep に ag(The Silver Searcher) を使う
"
let g:unite_source_grep_default_opts = '-Hn --color=never'
if executable('hw')
    let g:unite_source_grep_command = 'hw'
    let g:unite_source_grep_default_opts = '--no-group --no-color'
    let g:unite_source_grep_recursive_opt = ''
    let g:unite_source_grep_max_candidates = 200
elseif executable('pt')
    let g:unite_source_grep_command = 'pt'
    let g:unite_source_grep_default_opts = '--nocolor --nogroup'
    let g:unite_source_grep_recursive_opt = ''
    let g:unite_source_grep_max_candidates = 200
elseif executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nocolor --nogroup'
    let g:unite_source_grep_recursive_opt = ''
    let g:unite_source_grep_max_candidates = 200
elseif executable('ack-grep') || (has('mac') && executable('ack'))
    let g:unite_source_grep_command = 'ack'
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
" unite-tag
"---------------------------------------------------------------------------
autocmd BufEnter *
      \   if empty(&buftype)
      \|     noremap <silent> <C-J><C-K> :<C-u>UniteWithCursorWord -immediately tag<CR>
      \|  endif


"---------------------------------------------------------------------------
" vim-startify
"---------------------------------------------------------------------------
"startify
if executable('figlet')
    let g:startify_custom_header =
                \ map(split(system('figlet -f roman vim'), '\n'), '"   ". v:val') + ['','']
endif

    let g:startify_bookmarks = [ '~/.vimrc', '~/.vimrc.bundle', '~/.vimrc.local', '~/.zshrc', '~/.zshrc.osx']

    highlight StartifyBracket ctermfg=008
    highlight StartifyFooter  ctermfg=050
    highlight StartifyHeader  ctermfg=008
    highlight StartifyNumber  ctermfg=012
    highlight StartifyPath    ctermfg=255
    highlight StartifySlash   ctermfg=240
    highlight StartifySpecial ctermfg=250
"---------------------------------------------------------------------------
" vimrc を楽に開く&& 再読み込み
"---------------------------------------------------------------------------
" open .vimrc
command! Ev edit $MYVIMRC
command! Rv source $MYVIMRC

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
"let g:airline_branch_prefix = ' ⭠ '
"let g:airline_readonly_symbol = ' ⭤ '
"let g:airline_linecolumn_prefix = ' ⭡ '
"let g:airline_paste_symbol = 'ρ'

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
" multiple cursor
"---------------------------------------------------------------------------
let g:multi_cursor_use_default_mapping=1

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
" vimfiler
"---------------------------------------------------------------------------
set modifiable
set write
let g:vimfiler_enable_auto_cd = 1
let g:vimfiler_as_default_explorer=1
let g:vimfiler_safe_mode_by_default=0

nnoremap <Space> :<C-u>VimFiler -split -simple -winwidth=35 -no-quit<CR>
autocmd! FileType vimfiler call s:my_vimfiler_settings()
function! s:my_vimfiler_settings()
  nmap     <buffer><expr><Cr> vimfiler#smart_cursor_map("\<Plug>(vimfiler_execute)", "\<Plug>(vimfiler_edit_file)")
endfunction
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
" Local Settings
"---------------------------------------------------------------------------
source ~/.vimrc.local

