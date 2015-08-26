filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My bundles {{{
"" github
"Bundle 'Valloric/YouCompleteMe'
Bundle 'wincent/Command-T'
"Bundle 'mileszs/ack.vim'
Bundle 'rking/ag.vim'
Bundle 'rizzatti/dash.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'rstacruz/sparkup'
Bundle 'tpope/vim-surround'
Bundle 'sjl/gundo.vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-unimpaired'
Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'
Bundle 'godlygeek/tabular'
Bundle 'haya14busa/incsearch.vim'
Bundle 'chrisbra/vim-diff-enhanced'
Bundle 'guns/vim-clojure-static'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'tpope/vim-fireplace'
Bundle 'vim-scripts/paredit.vim'
Bundle 'venantius/vim-cljfmt'
Bundle 'majutsushi/tagbar'

"" vim.org
Bundle 'YankRing.vim'
Bundle 'Vimball'
" }}}

filetype plugin indent on     " required!

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set background=dark

set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set laststatus=2
set relativenumber
set undofile

"nnoremap / /\v
"vnoremap / /\v
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
" :h g:incsearch#auto_nohlsearch
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
let g:incsearch#consistent_n_direction = 1
let g:incsearch#magic = '\v'

set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85


set list
set listchars=tab:▸\ ,eol:¬

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

autocmd BufLeave,FocusLost * silent! wall

nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
nnoremap <leader>a :Ag
nnoremap <leader>ft Vatzf
nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>
nnoremap <leader>q gqip
nnoremap <leader>v V`]
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <leader>egv <C-w><C-v><C-l>:e $MYGVIMRC<cr>

nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

autocmd vimenter * if !argc() | NERDTree | endif
map <F3> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

nnoremap <silent> <F2> :YRShow<cr>
inoremap <silent> <F2> <ESC>:YRShow<cr>

nnoremap <silent> <F5> :GundoToggle<cr>
nnoremap <silent> <F8> :TagbarToggle<cr>
nnoremap <silent> <F10> :only<cr>

function! s:align()
    let p = '^\s*|\s.*\s|\s*$'
    if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
        let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
        Tabularize/|/l1
        normal! 0
        call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
endfunction
inoremap <silent> <Bar> <Bar><Esc>:call <SID>align()<CR>a


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LANGUAGES
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-cljfmt
let g:clj_fmt_autosave = 1

au Filetype html setlocal sw=2 ts=2 sts=2
au Filetype less setlocal sw=2 ts=2 sts=2


" Clojure
au Filetype clojure nmap <c-c><c-k> :Require<cr>
au Filetype clojure let g:clojure_fuzzy_indent = 1
au Filetype clojure let g:clojure_fuzzy_indent_patterns = ['^with', '^def', '^let']
au BufNewFile,BufRead *.edn set filetype=clojure
au Filetype clojure autocmd BufWritePre * :%s/\s\+$//e
function! TestToplevel() abort
    "Eval the toplevel clojure form (a deftest) and then test-var the
    "result."
    normal! ^
    let line1 = searchpair('(','',')', 'bcrn', g:fireplace#skip)
    let line2 = searchpair('(','',')', 'rn', g:fireplace#skip)
    let expr = join(getline(line1, line2), "\n")
    let var = fireplace#session_eval(expr)
    let result = fireplace#echo_session_eval("(clojure.test/test-var " . var . ")")
    return result
endfunction
au Filetype clojure nmap <c-c><c-t> :call TestToplevel()<cr>




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme mustang
