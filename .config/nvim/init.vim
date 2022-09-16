execute pathogen#infect()

syntax on
filetype plugin indent on

" Themeing
:colorscheme dracula
hi Normal ctermbg=none guibg=none

call matchadd('ColorColumn', '\%121v', -1)

set ruler
set number
set termguicolors
set nohlsearch
set guifont=Fira\ Code\ Nerd\ Font:h10

:let mapleader = " "
set undofile " Persistent Undo
set ignorecase 
set smartcase " don't ignore capitals in searches

nnoremap <Leader>vv :source ~/.config/nvim/init.vim<CR>

imap <c-j> <Plug>(copilot-next)
imap <c-k> <Plug>(copilot-previous)
if filereadable('/opt/homebrew/opt/node@16/bin/node')
  let g:copilot_node_command = '/opt/homebrew/opt/node@16/bin/node'
endif

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

augroup format_markdown
  autocmd FileType markdown setlocal wrap linebreak nolist
  autocmd FileType markdown vnoremap <expr> * (join(getline(getpos("'<")[1], getpos("'>")[1]), "\n") =~ "^\s*- " ? ":s/^\s*- //" : ":s/^/- /")."<CR>"
  autocmd FileType markdown nnoremap <expr> * (getline(getpos("'<")[1]) =~ "^\s*- " ? ":s/^\s*- //" : ":s/^/- /")."<CR>"
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
nnoremap <Leader>r :RuboCop .<CR>
nnoremap <Leader><Leader>r :RuboCop<CR>

autocmd VimResized * :wincmd =
" Resize panes with Alt- hjkl on Mac
nnoremap ˙ <C-W><
nnoremap ∆ <C-W>-
nnoremap ˚ <C-W>+
nnoremap ¬ <C-W>>

" Arrow keys
nnoremap <Up> :m .-2<cr>==
nnoremap <Down> :m .+1<cr>==
nnoremap <Left> <<
nnoremap <Right> >>

" Visual Arrow keys
vnoremap <Left> <gv
vnoremap <Right> >gv
vnoremap <Up> :m '<-2<CR>gv=gv
vnoremap <Down> :m '>+1<CR>gv=gv

" kj = <esc>
inoremap kj <esc>
cnoremap kj <esc>
vnoremap kj <esc>

" Commenting
" Apparently <C-_> maps <C-/>
nmap <C-_> <Plug>CommentaryLine
vmap <C-_> <Plug>Commentary
nmap <C-/> <Plug>CommentaryLine
vmap <C-/> <Plug>Commentary

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

" Undo breakpoints
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
inoremap <CR> <CR><c-g>u

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
nnoremap <tab> :call QuickFixToggle()<cr>

" Preserve c-i behaviour separate from tab with CSI u in iTerm2 and c-i
" remapped to Esc sequence i, to then be remapped back here
noremap <a-i> <c-i>

:hi VertSplit guibg=bg guifg=#555555
let &fcs='eob: ,vert:⎸'

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

nnoremap <Leader>l<Space> vip:EasyAlign *\ <CR>
nnoremap <Leader>l, vip:EasyAlign *,<CR>
nnoremap <Leader>l= vip:EasyAlign =<CR>
nnoremap <Leader>l\| vip:EasyAlign *\|<CR>

vnoremap <Leader>l<Space> :EasyAlign *\ <CR>
vnoremap <Leader>l, :EasyAlign *,<CR>
vnoremap <Leader>l= :EasyAlign =<CR>
vnoremap <Leader>l\| :EasyAlign *\|<CR>

let g:splitjoin_ruby_curly_braces = 0
let g:splitjoin_ruby_hanging_args = 0
let g:splitjoin_trailing_comma = 1

set mouse=a

"jump to first non-whitespace on line, jump to beginning of line if already at first non-whitespace
nnoremap <Home> :call LineHome()<CR>:echo<CR>
vnoremap <Home> :call LineHome()<CR>:echo<CR>
imap <Home> <C-R>=LineHome()<CR>
function! LineHome()
  let x = col('.')
  execute "normal! ^"
  if x == col('.')
    execute "normal! 0"
  endif
  return ""
endfunction
nnoremap 0 :call LineZero()<CR>:echo<CR>
vnoremap 0 :call LineZero()<CR>:echo<CR>
function! LineZero()
  let x = col('.')
  execute "normal! 0"
  if x == col('.')
    execute "normal! ^"
  endif
  return ""
endfunction

function! s:stripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")

  %s/\s\+$//e

  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
augroup stripTrailingWhitespacesPluginDetect
  autocmd FileType ruby,python,javascript,nix autocmd BufWritePre <buffer> :call <SID>stripTrailingWhitespaces()
augroup END

function! s:inNormalReplacingCursor(command)
  " Preparation: save cursor position.
  let l = line(".")
  let c = col(".")

  :execute "normal " . a:command

  " Clean up: restore previous cursor position
  call cursor(l, c)
endfunction
nnoremap <Leader>== :call <SID>inNormalReplacingCursor("gg=G")<CR>
nnoremap <Leader>=p :call <SID>inNormalReplacingCursor("=ip")<CR>
nnoremap <Leader>=r :call <SID>inNormalReplacingCursor("=ar")<CR>

" Select last paste/change
nnoremap <Leader>v `[v`]
nnoremap <Leader>V `[V`]

nnoremap <silent> <leader>og V:<c-u>call OpenCurrentFileInGithub()<cr>
xnoremap <silent> <leader>og :<c-u>call OpenCurrentFileInGithub()<cr>
function! OpenCurrentFileInGithub()
  let file_dir = expand('%:h')
  let git_root = system('cd ' . file_dir . '; git rev-parse --show-toplevel | tr -d "\n"')
  let file_path = substitute(expand('%:p'), git_root . '/', '', '')
  let branch = system('git symbolic-ref --short -q HEAD | tr -d "\n"')
  let git_remote = system('cd ' . file_dir . '; git remote get-url origin')
  let repo_path = matchlist(git_remote, ':\(.*\)\.')[1]
  let url = 'https:' . repo_path . '/blob/' . branch . '/' . file_path
  let first_line = getpos("'<")[1]
  let url .= '#L' . first_line
  let last_line = getpos("'>")[1]
  if last_line != first_line | let url .= '-L' . last_line | endif
  call system('open ' . url)
endfunction

nnoremap <leader>cp :let @* = expand('%')<cr>
nnoremap <leader>cap :let @* = expand('%:p')<cr>

let g:LanguageClient_serverCommands = {
      \ 'ruby': ['bundle', 'exec', 'srb', 'tc', '--lsp'],
      \ 'sh': ['bash-language-server', 'start'],
      \ 'yml': ['yaml-language-server']
      \ }
nmap <silent> K <Plug>(lcn-hover)
nmap <silent> gd <Plug>(lcn-definition)
nmap <leader>s <Plug>(lcn-menu)

:let g:ruby_indent_assignment_style = 'variable'
:let g:ruby_indent_hanging_elements = 0

let g:firenvim_config = { 'localSettings': { } }
let fc = g:firenvim_config['localSettings']
let fc['https?://[^/]+\.google\.com/'] = { 'takeover': 'never', 'priority': 1 }
let fc['https://app\.mode\.com/'] = { 'takeover': 'never', 'priority': 1 }
