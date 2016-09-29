syntax on 
set nocompatible
set enc=utf-8
set tabstop=8
set shiftwidth=4
set wildmenu 
set shellpipe=2>\&1\|nkf\ -uw>%s
set clipboard+=unnamed
set clipboard=unnamedplus
set mouse=a
set guioptions+=m
set ttymouse=xterm2
set number
set hlsearch
set noswapfile
set smartcase
set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8
set diffopt=vertical
set incsearch
set ruler
set cursorline
set laststatus=2
set statusline=2
set backspace=indent,eol,start

hi CursorLine term=underline cterm=underline guibg=Grey90

" Status line
let g:lightline = {'colorscheme': 'solarized',}

colorscheme ron

map <C-g> :Gtags
map <C-l> :Gtags -f %<CR>
map <C-j> :GtagsCursor<CR>
map <C-n> :cn<CR>
map <C-p> :cp<CR>
map <ESC><ESC> :noh<CR>

" sudo権限を付け忘れた時はw!!で保存できるようにする
"cnoremap w!! w !sudo tee > /dev/null %<CR> :e!<CR>

augroup BinaryXXD
  autocmd!
  autocmd BufReadPre  *.bin let &binary =1
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &binary | %!xxd -r | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END

" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" カーソル位置の単語をgrep検索
nnoremap <silent> ,g :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>

" grep検索結果の再呼出
nnoremap <silent> ,r :<C-u>UniteResume search-buffer<CR>

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
   let g:unite_source_grep_command = 'ag'
   let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
   let g:unite_source_grep_recursive_opt = ''
endif

if !exists('g:neocomplete#text_mode_filetypes')
	let g:neocomplete#text_mode_filetypes = {}
endif
let g:neocomplete#text_mode_filetypes = {
                \ 'rst': 1,
                \ 'markdown': 1,
                \ 'gitrebase': 1,
                \ 'gitcommit': 1,
                \ 'vcs-commit': 1,
                \ 'hybrid': 1,
                \ 'text': 1,
                \ 'help': 1,
                \ 'tex': 1,
                \ }

if &compatible
	set nocompatible
endif

set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))
	call dein#add('Shougo/dein.vim')
	call dein#add('Shougo/vimproc.vim', {'build': 'make'})
	call dein#add('Shougo/neocomplete.vim')
	call dein#add('rking/ag.vim')
	call dein#add('itchyny/lightline.vim')
	call dein#add('Shougo/unite.vim')
	call dein#add('ujihisa/neco-look')
	call dein#add('tpope/vim-fugitive')
	call dein#add('rhysd/committia.vim')
"	call dein#add('Shougo/neomru.vim')
"	call dein#add('Shougo/neosnippet')
call dein#end()

filetype plugin indent on

