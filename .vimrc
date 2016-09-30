syntax on

" 表示オプション **********************************************************************
"  行番号表示
set number
"  カーソルライン表示
set cursorline
"  ルーラー表示
set ruler
"  ウィンドウの末尾から2行目にステータスラインを常時表示
set laststatus=2
" コマンドラインに使われる画面上の行数
set cmdheight=1
" 対応する括弧やブレースを表示する
set showmatch

"set list
"set listchars=tab:>-
"hi NonText guibg=NONE guifg=DarkGreen
"hi SpecialKey guibg=NONE guifg=Gray40

" 検索オプション *********************************************************************
"  検索文字に大文字と小文字混在した時だけ区別
set smartcase
"  大文字と小文字を区別しない
set ignorecase
"  末尾から先頭へループして検索
" set nowrapscan
"  検索文字をハイライト
set hlsearch
"  インクリメンタルサーチ
set incsearch

" TAB/インデントオプション ***********************************************************
"  行頭の余白内でタブを打つとshiftwidthだけインデント
set smarttab
"  画面上でタブ文字が占める幅
set tabstop=8
"  タブ入力を複数の空白に置き換える
" set expandtab
"  自動インデントでズレる幅
set shiftwidth=8
"  連続した空白に対してtab, backspaceでカーソルが動く幅
set softtabstop=8
"  改行時に入力された行の末尾に合わせて次の行のインデントを増減
set smartindent
"  新しい行のインデントを現在行と同じにする
set autoindent

" マウス・キー動作 ********************************************************************
"  マウス有効
set mouse=a
"  バックスペースの挙動を変更
set backspace=2
"  ヤンクしたものをクリップボードに格納
set clipboard=unnamed,autoselect

" バックアップ、swpファイル ***********************************************************
"  swpファイルを作らない
set noswapfile
"  backupファイルを作らない
set nobackup

"  エンコーディング: UTF-8
set enc=utf-8

"  タブ補完
set wildmode=longest,full
"  DIFF左右表示
set diffopt=vertical

hi Normal ctermbg=black ctermfg=grey
hi StatusLine term=none cterm=none ctermfg=black ctermbg=grey
hi CursorLine term=none ctermfg=none ctermbg=darkgrey guifg=#8000ff gui=bold

" キーマップ **************************************************************************
"  GNU Global
map <C-g> :Gtags
map <C-h> :Gtags -f %<CR>
map <C-j> :GtagsCursor<CR>

map <C-n> :cn<CR>
map <C-p> :cp<CR>

" Uniteオプション *********************************************************************
" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" カーソル位置の単語をgrep
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
" grep検索結果の再呼出
nnoremap <silent> ,r :<C-u>UniteResume search-buffer<CR>

nnoremap [unite]    <Nop>
nmap     <Space>u [unite]
"  バッファ一覧
nnoremap <silent> [unite]b   :<C-u>Unite buffer<CR>

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
	let g:unite_source_grep_command = 'ag'
	let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
	let g:unite_source_grep_recursive_opt = ''
endif

" プラグイン設定 ****************************************************************************
set runtimepath^=~/.vim/dein/repos/github.com/Shougo/dein.vim
call dein#begin(expand('~/.vim/dein'))
	"  リスト
	call dein#add('Shougo/dein.vim')
	call dein#add('Shougo/unite.vim')
	call dein#add('Shougo/vimproc', {'build': 'make'})
	call dein#add('rking/ag.vim')
	call dein#add('ujihisa/unite-colorscheme')
	call dein#add('itchyny/lightline.vim')
	call dein#add('scrooloose/syntastic')
	call dein#add('tpope/vim-fugitive')
call dein#end()

filetype plugin indent on

"  未インストールのプラグインがあればインストール
if dein#check_install()
	call dein#install()
endif

" ステータスバー設定 ******************************************************************************************************************************************************************************************
let g:lightline = {
	\ 'colorscheme': 'powerline',
	\ 'mode_map': {'c': 'NORMAL'},
	\ 'active': {
	\   'left': [ ['mode', 'paste'], ['fugitive'] ]
	\ },
	\ 'component': {
	\   'lineinfo': 't %3l:%-2v',
	\ },
	\ 'component_function': {
	\   'fugitive': 'MyFugitive'
	\ }
\ }

"  gitのブランチ名を表示
function! MyFugitive()
	try
		if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head') && strlen(fugitive#head())
			return fugitive#statusline()
		endif
	catch
	endtry
	return ''
endfunction




