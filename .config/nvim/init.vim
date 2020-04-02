execute pathogen#infect()

syntax on
filetype plugin indent on

" Themeing
:colorscheme cobalt
hi Normal ctermbg=none guibg=none

set cursorline

call matchadd('ColorColumn', '\%121v', -1)

set ruler
set number
set termguicolors
set nohlsearch

:let mapleader = " "
set undofile " Persistent Undo
set ignorecase 
set smartcase " don't ignore capitals in searches

set completeopt+=menuone,noinsert,noselect
set shortmess+=c " Shut off completion messages
let g:mucomplete#enable_auto_at_startup = 1

:set shell=/bin/bash

set spell
set spelllang=en_ca
inoremap <C-f> <c-g>u<Esc>[s1z=`]a<c-g>u
nnoremap <C-f> [s1z=``

nnoremap Q @q

augroup gitrebase
  autocmd FileType gitrebase command -range RebasePick <line1>,<line2>s/^\w\+ /pick /
  autocmd FileType gitrebase command -range RebaseReword <line1>,<line2>s/^\w\+ /reword /
  autocmd FileType gitrebase command -range RebaseEdit <line1>,<line2>s/^\w\+ /edit /
  autocmd FileType gitrebase command -range RebaseSquash <line1>,<line2>s/^\w\+ /squash /
  autocmd FileType gitrebase command -range RebaseFixup <line1>,<line2>s/^\w\+ /fixup /
  autocmd FileType gitrebase command -range RebaseExec <line1>,<line2>s/^\w\+ /exec /
  autocmd FileType gitrebase command -range RebaseDrop <line1>,<line2>s/^\w\+ /drop /

  autocmd FileType gitrebase map rp :RebasePick<CR>
  autocmd FileType gitrebase map rr :RebaseReword<CR>
  autocmd FileType gitrebase map re :RebaseEdit<CR>
  autocmd FileType gitrebase map rs :RebaseSquash<CR>
  autocmd FileType gitrebase map rf :RebaseFixup<CR>
  autocmd FileType gitrebase map rx :RebaseExec<CR>
  autocmd FileType gitrebase map rd :RebaseDrop<CR>
augroup END

augroup format_ruby
  autocmd Syntax ruby syn region sorbetSig start='sig {' end='}'
  autocmd Syntax ruby syn region sorbetSigDo start='sig do' end='end'
  autocmd Syntax ruby hi def link sorbetSig Comment
  autocmd Syntax ruby hi def link sorbetSigDo Comment
augroup END

set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Use share yank/paste with MacOS clipboard
set clipboard=unnamed

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

nnoremap <Leader>a :Ack!<Space>

" Navigate panes with C-motion
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Arrow keys
nnoremap <Up> :m .-2<cr>
nnoremap <Down> :m .+1<cr>
nnoremap <Left> <<
nnoremap <Right> >>

" Visual Arrow keys
vnoremap <Left> <gv
vnoremap <Right> >gv
vnoremap <Up> :m '<-2<CR>gv
vnoremap <Down> :m '>+1<CR>gv

" kj = <esc>
inoremap kj <esc>
cnoremap kj <esc>
vnoremap kj <esc>

" kj reminder
inoremap <esc> <nop>
cnoremap <esc> <nop>
vnoremap <esc> <nop>

" Commenting
" Apparently <C-_> maps <C-/>
nmap <C-_> <Plug>CommentaryLine
vmap <C-_> <Plug>Commentary

" Skip the buffer with alt (mac)
nnoremap ∂ "_d
vnoremap ∂ "_d
nnoremap Î "_D
vnoremap Î "_D
nnoremap ç "_c
vnoremap ç "_c
nnoremap Ç "_C
vnoremap Ç "_C
nnoremap ≈ "_x
vnoremap ≈ "_x
nnoremap ˛ "_X
vnoremap ˛ "_X
vnoremap π "_dP

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

nnoremap <Leader>g :CtrlPBranchModified<CR>
nnoremap <Leader>d :CtrlPModified<CR>
" let g:ctrlp#modified#excludes = "^vendor"
let g:gitgutter_diff_base = "origin/HEAD"
let g:gitgutter_diff_args = '-w'
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

nnoremap <Leader>m :wa <bar> make<CR>

function! QuickFixToggle()
  let curr = winnr()
  for i in range(1, winnr('$'))
    let bnum = winbufnr(i)
    if getbufvar(bnum, '&buftype') == 'quickfix'
      if curr != i
        copen
        return
      endif
      cclose
      return
    endif
  endfor
  copen
endfunction 
nnoremap <c-i> :call QuickFixToggle()<cr>

:set fillchars+=vert:⎸
:hi VertSplit guibg=bg guifg=#555555

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

nnoremap <Leader>l<Space> vip:EasyAlign *\ <CR>
nnoremap <Leader>l, vip:EasyAlign *,<CR>
nnoremap <Leader>l= vip:EasyAlign =<CR>

vnoremap <Leader>l<Space> :EasyAlign *\ <CR>
vnoremap <Leader>l, :EasyAlign *,<CR>
vnoremap <Leader>l= :EasyAlign =<CR>

let g:splitjoin_ruby_curly_braces = 0
let g:splitjoin_ruby_hanging_args = 0

set mouse=a

"jump to first non-whitespace on line, jump to beginning of line if already at first non-whitespace
nnoremap <Home> :call LineHome()<CR>:echo<CR>
vnoremap <Home> :call LineHome()<CR>:echo<CR>
imap <Home> <C-R>=LineHome()<CR>
function! LineHome()
let x = col('.')
  execute "normal ^"
  if x == col('.')
    execute "normal 0"
  endif
  return ""
endfunction
