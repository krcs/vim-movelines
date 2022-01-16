" Vim plugin for moving lines in normal and visual mode.
" Last Change: 2021-05-29 
" Maintainer: Krzysztof Cieslak <https://github.com/krcs/vim-movelines.git>
" License: VIM
" :h license
" 
" Instalation:
"
" Copy movelines.vim into ~/.vim/plugin or $HOME/vimfiles/plugin directory.
"
" For normal mode call MoveLineNormal(direction).
" For virtual mode call MoveLineVisual(direcion).
"
" direction - Up,Down,Left,Right, words or only first letter.
"
" In the .vimrc file insert following lines to map keys,
" I am using Alt+[cursor key]:
"
" nnoremap <silent> <A-k> :call MoveLineNormal("u")<CR>
" nnoremap <silent> <A-j> :call MoveLineNormal("d")<CR>
" nnoremap <silent> <A-h> :call MoveLineNormal("l")<CR>
" nnoremap <silent> <A-l> :call MoveLineNormal("r")<CR>
" 
" xnoremap <silent> <A-k> :call MoveLinesVisual("Up")<CR>
" xnoremap <silent> <A-h> :call MoveLinesVisual("left")<CR>
" xnoremap <silent> <A-l> :call MoveLinesVisual("Right")<CR>
" xnoremap <silent> <A-j> :call MoveLinesVisual("down")<CR>
"

if exists("g:loaded_moveline")
    finish
endif
let g:loaded_moveline = 1

function! s:getDirection(direction) 
    if !len(a:direction)
        return ""
    endif
    
    let direction = tolower(a:direction[0])

    if index([ "u", "d", "l", "r" ], direction, 0, 1) == -1
        return ""
    endif

    return direction
endfunction

function! MoveLineNormal(direction)
    if mode() != 'n'
        return 1
    endif

    let direction = s:getDirection(a:direction)
    if !len(direction)
        return 1
    endif

    if direction ==? "r"
        exec "normal i \<ESC>l"
        return 0
    elseif direction ==? "l"
        normal! hx
        return 0
    endif

    let cursorPos = getcurpos()
    let currentRowNumber = getcurpos()[1]
    let currentColnumber = getcurpos()[2]

    let swapRowNumber = currentRowNumber
    if direction ==? "u"
        let swapRowNumber -= 1
    elseif direction ==? "d"
        let swapRowNumber += 1
    else
        return 0
    endif

    if (swapRowNumber <= 0) || (swapRowNumber > line("$"))
        return 0
    endif

    if direction ==? "u"
        move .-2<CR>
    elseif direction ==? "d"
        move .+1<CR>
    endif

    call cursor(swapRowNumber, currentColnumber)
    return 0
endfunction

function! MoveLinesVisual(direction) range
    let direction = s:getDirection(a:direction)

    let d = a:lastline - a:firstline
    if !len(direction)
        return 1
    endif

    if (direction ==? "u" && a:firstline == 1) 
        \ || (direction ==? "d" && a:lastline == line("$"))
        exec "normal v" . d . "\<CR>gv$"
        return 0
    endif

    if direction ==? "u"
       exec d == 0 ? "normal V:move '<-2\<CR>gv$"
                 \ : "normal V" . d . "\<CR>:move '<-2\<CR>gv$"
    elseif direction ==? "d"
        exec d == 0 ? "normal V:move '>+1\<CR>gv$"
                  \ : "normal V" . d . "\<CR>:move '>+1\<CR>gv$"
    elseif direction ==? "l"
        exec d == 0 ? "normal V:normal _X\<CR>gv$" 
                  \ : "normal V" . d . "\<CR>:normal _X\<CR>gv$"
    elseif direction ==? "r"
        exec d == 0 ? "normal V:normal i \<CR>gv$"
                  \ : "normal V" . d . "\<CR>$:normal i \<CR>gv$"
    endif
endfunction
