set makeprg=pdflatex\ %

setlocal noautoindent
setlocal textwidth=80
setlocal scrolloff=5
setlocal spell spelllang=en_us
setlocal thesaurus+=/home/frankgoji/.vim/thesaurus/mthesaur.txt
setlocal foldmethod=marker
setlocal foldmarker=!@@,@@!
setlocal indentexpr=''

inoremap <buffer> $ $$<left>
inoremap <buffer> <leader>$ $
inoremap <buffer> " ``"<left>
inoremap <buffer> <leader>' `'<left>
inoremap <buffer> <leader>em \emph{}<left>
inoremap <buffer> <leader>bf \textbf{}<left>
inoremap <buffer> <leader>ul \underline{}<left>
inoremap <buffer> <leader>sc \textsc{}<left>
inoremap <buffer> <leader>il <esc>:call Itemlist('', '(', ')')<left><left><left><left><left><left><left><left><left><left><left><left>

vnoremap <buffer> <leader>$ <Esc>`>a$<Esc>`<i$<Esc>`>ll

function! New_double_spaced_essay()
    0 read ~/.vim/templates/DOUBLE_SPACED_ESSAY.tex
    $ delete
endfunction

function! Itemlist(l, pre, post)
    for c in split(a:l, ',')
        execute "normal! ccitem[" . a:pre . c . a:post . "]\<esc>o\<esc>"
    endfor
endfunction
