let mapleader = "-"

let g:tex_flavor = "latex"

" Certain settings {{{
set nocompatible
set number
set et ts=4 sw=4 sts=4
set autoindent
set t_Co=256
set encoding=utf-8
silent! colo desert
silent! colo distinguished
set wildmode=longest,list
set wildmenu
set hidden
set linebreak
set incsearch
set hlsearch
" set textwidth=80
silent! set colorcolumn=81
syntax on
" }}}

filetype plugin indent on

" Insert mappings {{{
inoremap -+- <c-v>u2014
inoremap -. <c-v>u2022
inoremap ( ()<left>
inoremap { {}<left>
inoremap [ []<left>
inoremap " ""<left>
inoremap <leader>( (
inoremap <leader>{ {
inoremap <leader>[ [
inoremap <leader>" "
inoremap <leader>; <Esc>mqA;<Esc>`qa
inoremap <leader>< <><left>
inoremap jk <Esc>
inoremap jK <Esc>
inoremap <leader><Cr> <Cr><Esc>O
inoremap <c-u> <c-o>:stopinsert<cr>viwUea
" }}}

" Normal mappings {{{
nnoremap ; :
nnoremap j gj
nnoremap k gk
nnoremap / /\v
nnoremap <c-p> :set paste!<cr>
nnoremap <leader>n :bn<cr>
nnoremap <leader>p :bp<cr>
nnoremap <leader><c-u> viwUe
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>dh :nohlsearch<cr>
nnoremap <leader>ns :set nospell<cr>
nnoremap <leader>sp :setlocal spell spelllang=en_us
nnoremap <leader>ss :call Strip_spaces()<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
" }}}

" Visual mappings {{{
" REMAP ALL of these to do the ending one first
vnoremap <leader>" <Esc>`>a"<Esc>`<i"<Esc>`>ll
vnoremap <leader>' <Esc>`>a'<Esc>`<i'<Esc>`>ll
vnoremap <leader>( <Esc>`>a)<Esc>`<i(<Esc>`>ll
vnoremap <leader>[ <Esc>`>a]<Esc>`<i[<Esc>`>ll
vnoremap <leader>{ <Esc>`>a}<Esc>`<i{<Esc>`>ll
vnoremap <leader>< <Esc>`>a><Esc>`<i<<Esc>`>ll
" }}}

" Statusline that incorporates ruler and filetype {{{
set statusline=[%n]
set statusline+=\ %f:\ %10y%m%r%h
set statusline+=%=
set statusline+=(%l/%L),\ %v
set statusline+=%10P
" }}}

set laststatus=2
set scrolloff=5
set mousehide

" A function for stripping trailing whitespace {{{
function! Strip_spaces()
    normal mv
    %s/\s\+$//e
    normal `v
endfunction
" }}}

" A function to inform of latest created file {{{
function! New_File_Greeter()
    let filen = expand("%")
    let pathen = expand("%:p:h")
    echom "You have created " . filen . " at " . pathen . "."
endfunction
" }}}

" Various autogroups {{{
augroup Newfile
    autocmd BufNewFile * :call New_File_Greeter()
    autocmd BufNewFile *.java :call New_Java()
    autocmd BufNewFile *.c :call New_C()
    autocmd BufNewFile *.html :call New_html()
augroup END

augroup Writefile
    autocmd BufWrite * :call Strip_spaces()
augroup END

augroup Filetype_vim
    autocmd!
    autocmd Filetype vim setlocal foldmethod=marker
    autocmd Filetype vim nnoremap <leader>co I" <Esc>
augroup END

augroup Tex
    autocmd!
    autocmd Filetype tex setlocal indentexpr=
augroup END
" }}}

" Highlight corrections {{{
highlight SpellBad ctermbg=None ctermfg=9
" highlight Todostring ctermbg=green
highlight TodoEllipses ctermbg=red

" call matchadd('Todostring', '\(\cTODO.* \)\@<=.*')
call matchadd('TodoEllipses', '\( \)\@<=[\.]\{3\}')
" }}}
