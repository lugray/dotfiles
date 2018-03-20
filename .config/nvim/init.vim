execute pathogen#infect()

syntax on
filetype plugin indent on

" Themeing
:colorscheme cobalt

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
function! SetMaxWidth(width)
 execute "match OverLength /\\%" . (a:width + 1) . "v.\\+/"
endfunction
command! -nargs=1 Smw call SetMaxWidth(<f-args>)
call SetMaxWidth(120)

set ruler
set number
set termguicolors

:let mapleader = "-"

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

" Force myself to learn
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Commenting
" Apparently <C-_> maps <C-/>
nmap <C-_> <Plug>CommentaryLine
vmap <C-_> <Plug>Commentary

function! PickFromGitChangedSinceMaster()
  let a:realackprg = g:ackprg
  let g:ackprg = 'git-changed-since-master'
  call ack#Ack('grep', '.')
  let g:ackprg = a:realackprg
endfunction
command! Pfgcsm call PickFromGitChangedSinceMaster()
nnoremap <Leader>g :Pfgcsm<CR>
