set makeprg=pdflatex\ %

setlocal textwidth=80
setlocal scrolloff=5
setlocal spell spelllang=en_us
setlocal thesaurus+=/home/frankgoji/.vim/thesaurus/mthesaur.txt

inoremap <buffer> $ $$<left>
inoremap <buffer> <leader>$ $
inoremap <buffer> " ``"<left>
inoremap <buffer> <leader>' `'<left>

function! New_double_spaced_essay()
    0 read ~/.vim/templates/DOUBLE_SPACED_ESSAY.tex
    $ delete
endfunction
