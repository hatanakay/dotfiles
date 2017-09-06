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
" jj で インサートから抜ける
inoremap <silent> jj <ESC>

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
:function! TreeCWD()
    :NERDTreeClose
    :NERDTreeCWD
    wincmd p
:endfunction

let g:python3_host_prog  = expand("/usr/local/bin/python3")
call denite#custom#source('file_rec', 'matchers', ['matcher_cpsm'])
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
"call denite#custom#var('file_rec', 'command',
      "\ ['pt', '--follow', '--nocolor', '--nogroup', ''])
call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command',
    \ ['git', 'ls-files', '-co', '--exclude-standard'])

call denite#custom#var("file_rec", "command",
            \ [ "find", "-L", ":directory",
            \ "-path", "*/.svn/*", "-prune", "-o",
            \ '-type', 'l', '-print', '-o',
            \ '-type', 'f', '-print'])
nnoremap <silent> ,f :<C-u>Denite
    \ `finddir('.git', ';') != '' ? 'file_rec/git' : 'file_rec'`<CR>
nnoremap <silent> ,g   :<C-u>Denite grep<CR>
nnoremap <silent> ,cg  :<C-u>DeniteCursorWord grep<CR>
nnoremap <silent> ,l   :<C-u>Denite line<CR>
nnoremap <silent> ,b   :<C-u>Denite buffer<CR>
nnoremap <silent> ,d   :<C-u>Denite directory_rec -default-action=cd<CR>:call TreeCWD()<CR>
nnoremap <silent> ,m   :<C-u>Denite file_mru<CR>
nnoremap <silent> ,y   :<C-u>Denite neoyank<CR>
nnoremap <silent> ,o   :<C-u>Denite outline<CR>
nnoremap <silent> ,r   :<C-u>Denite -resume<CR>
nnoremap <silent> ,j   :<C-u>Denite jump change file_point<CR>
nnoremap <silent> ,e   :<C-u>Denite ghq -default-action=cd<CR>:call TreeCWD()<CR>
nnoremap <silent> ,z   :<C-u>Denite z -default-action=cd<CR>:call TreeCWD()<CR>

call denite#custom#map('insert', "<C-n>", '<denite:move_to_next_line>')
call denite#custom#map('insert', "<C-p>", '<denite:move_to_previous_line>')



nnoremap <leader>a :DeniteCursorWord -buffer-name=gtags_context gtags_context<cr>
nnoremap <leader>d :DeniteCursorWord -buffer-name=gtags_def gtags_def<cr>
nnoremap <leader>r :DeniteCursorWord -buffer-name=gtags_ref gtags_ref<cr>
nnoremap <leader>g :DeniteCursorWord -buffer-name=gtags_grep gtags_grep<cr>
nnoremap <leader>t :Denite -buffer-name=gtags_completion gtags_completion<cr>
nnoremap <leader>f :Denite -buffer-name=gtags_file gtags_file<cr>
nnoremap <leader>p :Denite -buffer-name=gtags_path gtags_path<cr>

"---------------------------------------------------------------------------
" vim-startify
"---------------------------------------------------------------------------
"startify
if executable('figlet')
    let g:startify_custom_header =
                \ map(split(system('figlet -f roman neovim'), '\n'), '"   ". v:val') + ['','']
endif

let g:startify_bookmarks = [ '~/.config/nvim/init.vim', '~/.config/nvim/settings.vim', '~/.config/nvim/dein.toml', '~/.zshrc', '~/.zshrc.osx']

highlight StartifyBracket ctermfg=008
highlight StartifyFooter  ctermfg=050
highlight StartifyHeader  ctermfg=008
highlight StartifyNumber  ctermfg=012
highlight StartifyPath    ctermfg=255
highlight StartifySlash   ctermfg=240
highlight StartifySpecial ctermfg=250

"---------------------------------------------------------------------------
" deoplete
"---------------------------------------------------------------------------
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#enable_camel_case = 0
let g:deoplete#enable_ignore_case = 0
let g:deoplete#enable_refresh_always = 0
let g:deoplete#enable_smart_case = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.ruby = ['[^. *\t]\.\w*', '\h\w*::']


"---------------------------------------------------------------------------
" NERDTree
"---------------------------------------------------------------------------
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | wincmd p | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <Space> :NERDTreeToggle<CR>

let g:NERDTreeChDirMode=2
let g:NERDTreeChDirMode=1
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeMinimalUI = 25
let g:NERDTreeCascadeSingleChildDir = 0
let g:NERDTreeShowHidden = 1
let g:NERDTreeRespectWildIgnore = 0
let g:NERDTreeAutoDeleteBuffer = 0
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeQuitOnOpen = 1
let NERDTreeIgnore = [
	\ '\.git$', '\.hg$', '\.svn$', '\.stversions$', '\.pyc$', '\.svn$',
	\ '\.DS_Store$', '\.sass-cache$', '__pycache__$', '\.egg-info$'
	\ ]
"---------------------------------------------------------------------------
" Open Brower Github
"---------------------------------------------------------------------------
let g:openbrowser_github_always_used_branch='master'
let g:openbrowser_github_url_exists_check='ignore'
:function! OpenWithVisual()
    call setpos("'<", getpos("."))
    call setpos("'>", getpos("."))
    normal! gv
    :'<,'>OpenGithubFile
:endfunction
command! Gh :call OpenWithVisual()
nnoremap <C-l> :call OpenWithVisual()<CR>

"---------------------------------------------------------------------------
" markdown preview
"---------------------------------------------------------------------------
let g:quickrun_config = {}
let g:quickrun_config.markdown = {
            \ 'outputter' : 'null',
            \ 'command'   : 'open',
            \ 'cmdopt'    : '-a',
            \ 'args'      : 'Marked',
            \ 'exec'      : '%c %o %a %s',
            \ }

"---------------------------------------------------------------------------
" Align vim
"---------------------------------------------------------------------------
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
