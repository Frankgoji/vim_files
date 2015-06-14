let g:bullet = "•"
let s:formerformatops = "tcroq"
let &l:formatoptions = s:formerformatops
set textwidth=80

setlocal thesaurus+=/home/frankgoji/.vim/thesaurus/mthesaur.txt
setlocal spell spelllang=en_us

inoremap <buffer> <leader>b a<esc>:execute "normal! r" . g:bullet<cr>a
nnoremap <buffer> <leader>wp :call WordProcessor()<cr>
nnoremap <buffer> <leader>cp :call TextProcess#CopyPaste()<cr>
nnoremap <buffer> <leader>ol :call Outliner()<cr>

" Function setting Word Processor mode
function! WordProcessor()
    setlocal noautoindent
    setlocal wrap
    setlocal linebreak
    let &l:formatoptions = s:formerformatops . "2"
    inoremap <buffer> <cr> <cr><tab>
    nnoremap <buffer> o A<cr><tab>
    nnoremap <buffer> O I<cr><esc>kcc<tab>
endfunction

" Function setting rudimentary outliner mode
" Make <cr>, o, and O call a function (with args) that will put the bullet in
" the right place regardless of whether on the first line or not.
function! Outliner()
    call WordProcessor()
    let &l:formatoptions = s:formerformatops . "n"
    let temp = "^\\s*\\(\\d\\+[\\]:.)}\\t\ ]\\|"
    let temp .= g:bullet . "\\)\\s*"
    let &l:formatlistpat = temp
    inoremap <buffer> <tab> a<esc>:call Tab(">")<cr>cl
    inoremap <buffer> <S-tab> a<esc>:call Tab("<")<cr>cl
    inoremap <buffer> <cr> a<esc>:call Enter("cr")<cr>a
    nnoremap <buffer> o ia<esc>:call Enter("o")<cr>A
    nnoremap <buffer> O ia<esc>:call Enter("O")<cr>A
endfunction

" Write a de-outliner function, map Esc to it
" Figure out what to do when it goes multiple lines

" Function for handling tabs and shift-tabs in insert mode so that the cursor
" stays in the right place.
function! Tab(dir)
    let cursor_pos = getpos('.')
    if a:dir ==# ">"
        normal! >>
        let cursor_pos[2] += 4
        call cursor(cursor_pos[1:])
    elseif a:dir ==# "<"
        normal! <<
        let cursor_pos[2] -= 4
        call cursor(cursor_pos[1:])
    endif
endfunction

" Function for o, O, and <cr> that puts the bullet in the right place,
" regardless of whether or not it's on the first line.
function! Enter(key)
    " Search for last bullet, from 0th line to current, to find the position,
    " then go to appropriate line, insert appropriate number of spaces, and
    " the bullet.
    normal! ma
    let prev_bullet_pos = 0
    let cursor_pos = getpos('.')
    let lnum = cursor_pos[1] + 1
    try
        execute "0," . lnum . "?" . g:bullet
        let new_cursor_pos = getpos('.')
        let prev_bullet_pos += new_cursor_pos[2]
    endtry
    normal! `a
    if a:key ==# "o"
        execute "normal! xo\<esc>Vc\<esc>"
    elseif a:key ==# "O"
        execute "normal! xO\<esc>Vc\<esc>"
    elseif a:key ==# "cr"
        execute ":normal! r\<cr>"
    endif
    execute "normal! i\<c-o>" . prev_bullet_pos . "i \<esc>"
    execute "normal! i" . g:bullet . "\<right>"
endfunction
