set nocompatible
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" My bundles {{{
"" github
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'mileszs/ack.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Yggdroot/hiPairs'
Plugin 'airblade/vim-gitgutter'
Plugin 'amix/vim-zenroom2'
Plugin 'chrisbra/vim-diff-enhanced'
Plugin 'godlygeek/tabular'
Plugin 'guns/vim-clojure-static'
Plugin 'haya14busa/incsearch.vim'
Plugin 'junegunn/goyo.vim'
Plugin 'junegunn/limelight.vim'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'leshill/vim-json'
Plugin 'majutsushi/tagbar'
Plugin 'mattn/gist-vim'
Plugin 'mattn/webapi-vim'
Plugin 'mxw/vim-jsx'
Plugin 'pangloss/vim-javascript'
Plugin 'plasticboy/vim-markdown'
Plugin 'rizzatti/dash.vim'
Plugin 'rking/ag.vim'
Plugin 'rstacruz/sparkup'
Plugin 'sbdchd/neoformat'
Plugin 'scrooloose/nerdtree'
Plugin 'sjl/gundo.vim'
Plugin 'suan/vim-instant-markdown'
Plugin 'tpope/vim-fireplace'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'venantius/vim-cljfmt'
Plugin 'vim-scripts/paredit.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'wincent/Command-T'

"" vim.org
Plugin 'YankRing.vim'
Plugin 'Vimball'
" }}}

call vundle#end()            " required

filetype plugin indent on     " required!

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

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

set lazyredraw

" Syntastic {{{

augroup js
    "au FileType javascript setlocal foldmethod=syntax
    "au FileType javascript setlocal foldnestmax=1
    au FileType javascript setlocal sw=2 ts=2
    au FileType javascript silent! :%foldopen!
    au BufWritePre,TextChanged,InsertLeave *.js Neoformat

    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
augroup END
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ["eslint"]
let g:jsx_ext_required = 0

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
" }}}

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
"colorscheme mustang
colorscheme solarized
set background=dark

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CSCOPE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocsverb
if filereadable("cscope.out")
else
    if $ANDROID_BUILD_TOP !=""
        "This assumes you have sourced the Android build environment
        cscope add $ANDROID_BUILD_TOP/cscope.out
 else
        "Or, you can point to your android source directory in $ANDROID_DIR
        cscope add $ANDROID_DIR/cscope.out
    endif
endif
