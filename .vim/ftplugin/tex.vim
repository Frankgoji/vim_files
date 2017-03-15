set makeprg=pdflatex\ %

setlocal noautoindent
setlocal textwidth=80
setlocal scrolloff=5
setlocal spell spelllang=en_us
setlocal thesaurus+=/home/frankgoji/.vim/thesaurus/mthesaur.txt
setlocal foldmethod=marker
setlocal foldmarker=!@@,@@!

inoremap <buffer> $ $$<left>
inoremap <buffer> <leader>$ $
inoremap <buffer> " ``"<left>
inoremap <buffer> <leader>' `'<left>
inoremap <buffer> <leader>em \emph{}<left>
inoremap <buffer> <leader>bf \textbf{}<left>
inoremap <buffer> <leader>ul \underline{}<left>
inoremap <buffer> <leader>sc \textsc{}<left>
inoremap <buffer> <leader>tt \texttt{}<left>
inoremap <buffer> <leader>il <esc>:call Itemlist('', '(', ')')<left><left><left><left><left><left><left><left><left><left><left><left>
inoremap <buffer> <leader>xo <c-x><c-o>

vnoremap <buffer> <leader>$ <Esc>`>a$<Esc>`<i$<Esc>`>ll

function! New_double_spaced_essay()
    0 read ~/.vim/templates/DOUBLE_SPACED_ESSAY.tex
    $ delete
endfunction

function! Itemlist(l, pre, post)
    for c in split(a:l, ',')
        execute "normal! cc\\item[" . a:pre . c . a:post . "]\<esc>o\<esc>"
    endfor
endfunction

function! Before(pa, pb)
    " Returns 1 if pa is before pb, 0 otherwise
    return a:pa[1] < a:pb[1] || (a:pa[1] == a:pb[1] && a:pa[2] < a:pb[2])
endfunction

function! BeginTagCompletion(findstart, base)
    if a:findstart
        " find start of \end{ if it exists, else return the cursor pos
        let currpos = getcurpos()
        let endtag = search('\\e\(n\)\?\(d\)\?\({\)\?', 'bW')
        let newpos = getcurpos()
        if endtag == 0 || newpos[1] != currpos[1]
            return currpos[2]
        endif
        " ensure that the \end{ is the word on the cursor
        echom "search returned " . (newpos[2] - 1)
        call setpos('.', currpos)
        normal! B
        if getcurpos()[2] == newpos[2]
            return newpos[2] - 1
        endif
        return currpos[2]
    endif
    let begin = search('\\begin{', 'bW')
    if begin == 0
        return -1
    endif
    normal! 2w"zyi{
    let repl = "\\end{" . @z . "}"
    echom 'replacement is ' . repl
    if match(a:base, '\\e\(n\)\?\(d\)\?\({\)\?') == -1
        echom 't' . a:base . 't'
        if a:base != ""
            let base = a:base . " "
        else
            let base = ""
        endif
    else
        let base = ""
    endif
    return [base . repl]
endfunction

set omnifunc=BeginTagCompletion
