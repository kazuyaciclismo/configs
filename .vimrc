syntax on
set number
set smartcase
set smartindent
set smarttab
set tabstop=8
set shiftwidth=8
set nowrapscan
set incsearch
set autoindent
set mouse=a
set nocompatible
set cursorline
set laststatus=2

hi Normal ctermbg=black ctermfg=grey
hi StatusLine term=none cterm=none ctermfg=black ctermbg=grey
hi CursorLine term=none ctermfg=none ctermbg=darkgrey guifg=#8000ff gui=bold

map <C-g> :Gtags
map <C-h> :Gtags -f %<CR>
map <C-j> :GtagsCursor<CR>
map <C-n> :cn<CR>
map <C-p> :cp<CR>

filetype plugin indent on 

" grep
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>

if executable('ag')
	let g:unite_source_grep_command = 'ag'
	let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
	let g:unite_source_grep_recursive_opt = ''
endif

"dein Scripts-----------------------------
if &compatible
	set nocompatible               " Be iMproved
endif

" Required:
set runtimepath^=~/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('~/.vim/dein'))

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/vimproc', {'build': 'make'})
call dein#add('rking/ag.vim')
call dein#add('ujihisa/unite-colorscheme')
call dein#add('itchyny/lightline.vim')
call dein#add('scrooloose/syntastic')
call dein#add('tpope/vim-fugitive')

" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
	call dein#install()
endif

"End dein Scripts-------------------------
"

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

function! MyFugitive()
	try
		if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head') && strlen(fugitive#head())
			return fugitive#statusline()
		endif
	catch
	endtry
	return ''
endfunction




