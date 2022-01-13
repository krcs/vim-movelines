# vim-movelines

Vim plugin for moving lines in normal and visual mode.

### Installation

If you use vim-plug add Plug to your config
`Plug 'krcs/vim-movelines'`

Or just copy `movelines.vim` into `~/.vim/plugin` or `$HOME/vimfiles/plugin` directory.

For normal mode call `MoveLineNormal(direction)`.
For virtual mode call `MoveLinesVisual(direcion)`.

`direction` - Up,Down,Left,Right, words or only first letter.

In the .vimrc file insert following lines to map keys,
I am using Alt+[cursor key]:

```
nnoremap <silent> <A-k> :call MoveLineNormal("u")<CR>
nnoremap <silent> <A-j> :call MoveLineNormal("d")<CR>
nnoremap <silent> <A-h> :call MoveLineNormal("l")<CR>
nnoremap <silent> <A-l> :call MoveLineNormal("r")<CR>
```

```
xnoremap <silent> <A-k> :call MoveLinesVisual("Up")<CR>
xnoremap <silent> <A-h> :call MoveLinesVisual("left")<CR>
xnoremap <silent> <A-l> :call MoveLinesVisual("Right")<CR>
xnoremap <silent> <A-j> :call MoveLinesVisual("down")<CR>
```

### Examples

#### Normal mode

![Normal mode](/MoveLinesNormal.gif)

#### Visual mode

![Visual mode](/MoveLinesVisual.gif)

### License
Same as Vim. See `:h license`
