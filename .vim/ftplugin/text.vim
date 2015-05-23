let g:bullet = "•"
let s:formerformatops = "tcroq"
let &l:formatoptions = s:formerformatops
set textwidth=80

setlocal thesaurus+=/home/frankgoji/.vim/thesaurus/mthesaur.txt

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
    setlocal noautoindent
    let &l:formatoptions = s:formerformatops . "n"
    let temp = "^\\s*\\(\\d\\+[\\]:.)}\\t\ ]\\|"
    let temp .= g:bullet . "\\)\\s*"
    let &l:formatlistpat = temp
    inoremap <buffer> <tab> a<esc>:call Tab(">")<cr>cl
    inoremap <buffer> <S-tab> a<esc>:call Tab("<")<cr>cl
    "inoremap <buffer> <cr> <esc>:execute "normal! A" . g:bullet . " "<cr>hi<cr><esc>XxA
    "nnoremap <buffer> o :execute "normal! A" . g:bullet . " "<cr>hi<cr><esc>XxA
    "nnoremap <buffer> O I<cr><esc>k:execute "normal! a" . g:bullet . " "<cr>a
endfunction

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
    if a:key ==# "o"
        echo "o pressed"
    elseif a:key ==# "O"
        echo "Big O pressed"
    elseif a:key ==# "<cr>"
        echo "<cr> pressed"
    endif
endfunction
