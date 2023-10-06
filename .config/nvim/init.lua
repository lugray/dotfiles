vim.cmd("execute pathogen#infect()")

-- Themeing
vim.cmd.colorscheme('dracula')
vim.g.dracula_colorterm = 0
vim.cmd('hi Normal ctermbg=none guibg=none')

vim.opt.ruler = true
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.hlsearch = false
vim.opt.guifont = "Fira Code Nerd Font:h10"

vim.g.mapleader = " "
vim.opt.undofile = true
vim.opt.ignorecase  = true
vim.opt.smartcase = true

require("nvim-tree").setup()

function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end
function nmap(shortcut, command)
  map('n', shortcut, command)
end
function imap(shortcut, command)
  map('i', shortcut, command)
end
function cmap(shortcut, command)
  map('c', shortcut, command)
end
function vmap(shortcut, command)
  map('v', shortcut, command)
end
function xmap(shortcut, command)
  map('x', shortcut, command)
end

nmap("<Leader>vv", ":source ~/.config/nvim/init.lua<CR>")

imap ("<c-j>", "<Plug>(copilot-next)")
imap ("<c-k>", "<Plug>(copilot-previous)")

vim.cmd([[
if filereadable('/opt/homebrew/opt/node@16/bin/node')
  let g:copilot_node_command = '/opt/homebrew/opt/node@16/bin/node'
endif
]])

vim.opt.shell = "/bin/bash"

vim.opt.spell = true
vim.opt.spelllang = "en_ca"
imap("<C-f>", "<c-g>u<Esc>[s1z=`]a<c-g>u")
nmap("<C-f>", "[s1z=``")

nmap("Q", "@q")

vim.cmd([[
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

augroup format_go
  autocmd FileType go map gc :GoCallers<CR>
augroup END
]])

vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- Use share yank/paste with MacOS clipboard
vim.opt.clipboard = "unnamed"

-- Allow saving of files as sudo when I forgot to start vim using sudo.
cmap("w!!", "w !sudo tee > /dev/null %")

nmap("<Leader>a", ":Rg<Space>")

vim.g.vimrubocop_keymap = 0
nmap("<Leader>s", ":RuboCop .<CR>")
nmap("<Leader><Leader>s", ":RuboCop<CR>")

-- autocmd VimResized * :wincmd =
-- Resize panes with Alt- hjkl on Mac
nmap("˙", "<C-W><")
nmap("∆", "<C-W>-")
nmap("˚", "<C-W>+")
nmap("¬", "<C-W>>")

-- Arrow keys
nmap("<Up>", ":m .-2<cr>==")
nmap("<Down>", ":m .+1<cr>==")
nmap("<Left>", "<<")
nmap("<Right>", ">>")

-- Visual Arrow keys
vmap("<Left>", "<gv")
vmap("<Right>", ">gv")
vmap("<Up>", ":m '<-2<CR>gv=gv")
vmap("<Down>", ":m '>+1<CR>gv=gv")

-- kj = <esc>
vim.cmd([[
call arpeggio#load()
Arpeggio inoremap kj <esc>
Arpeggio cnoremap kj <esc>
Arpeggio vnoremap kj <esc>
Arpeggio xnoremap kj <esc>
Arpeggio nnoremap kj <esc>
]])

-- Commenting
-- Apparently <C-_> maps <C-/>
nmap("<C-_>", "<Plug>CommentaryLine")
vmap("<C-_>", "<Plug>Commentary")
nmap("<C-/>", "<Plug>CommentaryLine")
vmap("<C-/>", "<Plug>Commentary")

-- Skip the buffer with alt (mac)
nmap("∂", '"_d')
vmap("∂", '"_d')
nmap("Î", '"_D')
vmap("Î", '"_D')
nmap("ç", '"_c')
vmap("ç", '"_c')
nmap("Ç", '"_C')
vmap("Ç", '"_C')
nmap("≈", '"_x')
vmap("≈", '"_x')
nmap("˛", '"_X')
vmap("˛", '"_X')
vmap("π", '"_dP')

-- Undo breakpoints
imap(",", ",<c-g>u")
imap(".", ".<c-g>u")
imap("!", "!<c-g>u")
imap("?", "?<c-g>u")
imap("<CR>", "<CR><c-g>u")

vim.g.ctrlp_map = '<Leader>p'
vim.g.ctrlp_user_command = { '.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard' }

nmap("<Leader>g", ":CtrlPBranchModified<CR>")
nmap("<Leader>d", ":CtrlPModified<CR>")
vim.g.gitgutter_diff_base = "origin/HEAD"
vim.g.gitgutter_diff_args = '-w'
nmap("<Leader>hj", "<Plug>(GitGutterNextHunk)")
nmap("<Leader>hk", "<Plug>(GitGutterPrevHunk)")

nmap("<Leader>m", ":wa <bar> make<CR>")

vim.cmd([[
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
]])
nmap("<tab>", ":call QuickFixToggle()<cr>")

-- Mapping tab also maps <C-I> ಠ_ಠ. Set it back.
nmap("<C-I>", "<C-I>")

-- :hi VertSplit guibg=bg guifg=#555555
-- let &fcs='eob: ,vert:⎸'

-- Start interactive EasyAlign in visual mode (e.g. vipga)
xmap("ga", "<Plug>(EasyAlign)")

-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap("ga", "<Plug>(EasyAlign)")

nmap("<Leader>l<Space>", "vip:EasyAlign *\\ <CR>")
nmap("<Leader>l,", "vip:EasyAlign *,<CR>")
nmap("<Leader>l=", "vip:EasyAlign =<CR>")
nmap("<Leader>l\\|", "vip:EasyAlign *\\|<CR>")

vmap("<Leader>l<Space>", ":EasyAlign *\\ <CR>")
vmap("<Leader>l,", ":EasyAlign *,<CR>")
vmap("<Leader>l=", ":EasyAlign =<CR>")
vmap("<Leader>l\\|", ":EasyAlign *\\|<CR>")

vim.g.splitjoin_ruby_curly_braces = 0
vim.g.splitjoin_ruby_hanging_args = 0
vim.g.splitjoin_trailing_comma = 1

vim.opt.mouse = "a"

-- jump to first non-whitespace on line, jump to beginning of line if already at first non-whitespace
nmap("<Home>", ":call LineHome()<CR>:echo<CR>")
vmap("<Home>", ":call LineHome()<CR>:echo<CR>")
imap("<Home>", "<C-R>=LineHome()<CR>")
vim.cmd([[
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
  autocmd FileType ruby,python,javascript,nix autocmd BufWritePre <buffer> :call stripTrailingWhitespaces()
augroup END

function! s:inNormalReplacingCursor(command)
  " Preparation: save cursor position.
  let l = line(".")
  let c = col(".")

  :execute "normal " . a:command

  " Clean up: restore previous cursor position
  call cursor(l, c)
endfunction
]])
nmap("<Leader>==", ':call inNormalReplacingCursor("gg=G")<CR>')
nmap("<Leader>=p", ':call inNormalReplacingCursor("=ip")<CR>')
nmap("<Leader>=r", ':call inNormalReplacingCursor("=ar")<CR>')

-- Select last paste/change
nmap("<Leader>v", "`[v`]")
nmap("<Leader>V", "`[V`]")

nmap("<silent>", "<Leader><Leader>g V:<c-u>call OpenCurrentFileInGithub()<cr>")
xmap("<silent>", "<Leader><Leader>g :<c-u>call OpenCurrentFileInGithub()<cr>")
vim.cmd([[
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
]])

nmap("<Leader>cp", ":let @* = expand('%')<cr>")
nmap("<Leader>cap", ":let @* = expand('%:p')<cr>")

vim.g.LanguageClient_serverCommands = {
  ruby = { 'bundle', 'exec', 'srb', 'tc', '--lsp' },
  sh = { 'bash-language-server', 'start' },
  yml = { 'yaml-language-server' }
}
nmap("<silent>", "K <Plug>(lcn-hover)")
nmap("<silent>", "gd <Plug>(lcn-definition)")
nmap("<Leader>ls", "<Plug>(lcn-menu)")

vim.g.ruby_indent_assignment_style = 'variable'
vim.g.ruby_indent_hanging_elements = 0

nmap("<Leader>o", "<C-o>")
nmap("<Leader>i", "<C-i>")
nmap("<Leader>r", "<C-r>")
