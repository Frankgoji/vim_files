" Function making a copy-paste friendly version of the document
function! TextProcess#CopyPaste()
    execute "normal! :w!\<cr>"
    let filelocation = expand('%:p')
    let filelocation = substitute(filelocation, '\s', '\\ ', "")
    let filename = expand('%:t:r')
    execute "normal! :e " . filename . "CP.txt\r"
    execute "0 read " . filelocation
    normal! Gddgg
    let totallines = line("$")
    let currline = line(".")
    while (currline !=# totallines)
        normal! j"ayyk
        let line = @a
        if (match(line, "   ") ==? -1)
            normal! J
        else
            normal! j04x
        endif
        let totallines = line("$")
        let currline = line(".")
    endwhile
    nohlsearch
endfunction
