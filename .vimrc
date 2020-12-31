let mapleader = "\<tab>"
execute pathogen#infect()
syntax on

set colorcolumn=80,120

au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn

colorscheme solarized
set bg=dark

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set backspace=2

set splitbelow
set splitright

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Highlight extra whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

"autocmd BufWritePre *.py execute ':Black'

let g:SimpylFold_docstring_preview = 1

" https://stackoverflow.com/questions/9403098/is-it-possible-to-jump-to-the-next-closed-fold-in-vim
nnoremap <silent> <leader>zj :call NextClosedFold('j')<cr>
nnoremap <silent> <leader>zk :call NextClosedFold('k')<cr>

" zj, zk
function! NextClosedFold(dir)
    let cmd = 'norm!z' . a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction

" start unfolded
autocmd BufWinEnter * let &foldlevel = max(map(range(1, line('$')), 'foldlevel(v:val)'))

" https://github.com/vim/vim/issues/2712#issuecomment-372968129
" set re=1

" https://stackoverflow.com/questions/4027222/using-shorter-textwidth-in-comments-and-docstrings
autocmd BufEnter *.py nmap <F6> :setlocal textwidth=72<CR>gqj:setlocal textwidth=79<CR>
"packloadall
