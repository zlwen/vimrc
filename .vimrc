set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-scripts/ack.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'winmanager'
Plugin 'godlygeek/tabular'
Plugin 'kien/ctrlp.vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'majutsushi/tagbar'
Bundle 'The-NERD-tree'

call vundle#end()

set number
set relativenumber
let g:molokai_original = 1

"syntax highlight
syntax on

"set shiftwidth
set shiftwidth=4

"set tabstop
set tabstop=4

"set softtabstop
set softtabstop=4

"set indent
filetype indent on
autocmd FileType python setlocal et sta sw=4 sts=4

"status line
set laststatus=2

" winmanager
nmap <C-m> :WMToggle<CR>

function! NERDTree_Start()  
	exec 'NERDTree'  
endfunction

function! NERDTree_IsValid()  
	return 1  
endfunction

" auto refresh
set autoread

" set PageDown PageUp
nmap J <C-f>
nmap K <C-b>


" format xml
function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! Fxml call DoPrettyXML()

" folding setting
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use
nnoremap <Space> za

" color scheme
set background=dark
"set background=light
let g:solarized_termcolors=256
"colorscheme solarized
colorscheme gruvbox

" vimdiff color scheme
"if &diff
"	colorscheme solarized
"endif

" neocomplcache
"let g:neocomplcache_enable_at_startup=1

" use ; replace for :
nnoremap ; :
vmap ; :

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = '>'
nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprevious<CR>

nnoremap <F8> :TagbarToggle<CR>
vmap <F8> :TagbarToggle<CR>
