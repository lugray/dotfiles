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

function augroup(name, event, pattern, commands)
  local group = vim.api.nvim_create_augroup(name, { clear = true })
  for _, command in pairs(commands) do
    vim.api.nvim_create_autocmd(event, {
      command = command,
      group = group,
      pattern = pattern,
    })
  end
end

nmap("<Leader>vv", ":source ~/.config/nvim/init.lua<CR>")

imap ("<c-j>", "<Plug>(copilot-next)")
imap ("<c-k>", "<Plug>(copilot-previous)")

vim.opt.shell = "/bin/bash"

vim.opt.spell = true
vim.opt.spelllang = "en_ca"
imap("<C-f>", "<c-g>u<Esc>[s1z=`]a<c-g>u")
nmap("<C-f>", "[s1z=``")

nmap("Q", "@q")

augroup("gitrebase", "FileType", "gitrebase", {
  "command -range RebasePick <line1>,<line2>s/^\\w\\+ /pick /",
  "command -range RebaseReword <line1>,<line2>s/^\\w\\+ /reword /",
  "command -range RebaseEdit <line1>,<line2>s/^\\w\\+ /edit /",
  "command -range RebaseSquash <line1>,<line2>s/^\\w\\+ /squash /",
  "command -range RebaseFixup <line1>,<line2>s/^\\w\\+ /fixup /",
  "command -range RebaseExec <line1>,<line2>s/^\\w\\+ /exec /",
  "command -range RebaseDrop <line1>,<line2>s/^\\w\\+ /drop /",
  "map rp :RebasePick<CR>",
  "map rr :RebaseReword<CR>",
  "map re :RebaseEdit<CR>",
  "map rs :RebaseSquash<CR>",
  "map rf :RebaseFixup<CR>",
  "map rx :RebaseExec<CR>",
  "map rd :RebaseDrop<CR>",
})
augroup("format_ruby", "Syntax", "ruby", {
  "syn region sorbetSig start='sig {' end='}'",
  "syn region sorbetSigDo start='sig do' end='end'",
  "hi def link sorbetSig Comment",
  "hi def link sorbetSigDo Comment",
})
augroup("format_markdown", "FileType", "markdown", {
  "setlocal wrap linebreak nolist",
  [[vnoremap <expr> * (join(getline(getpos("'<")[1], getpos("'>")[1]), "\\n") =~ "^\\s*- " ? ":s/^\\s*- //" : ":s/^/- /")."<CR>"]],
  [[nnoremap <expr> * (getline(getpos("'<")[1]) =~ "^\\s*- " ? ":s/^\\s*- //" : ":s/^/- /")."<CR>"]],
})
augroup("format_go", "FileType", "go", {
  "map gc :GoCallers<CR>",
})

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
nmap("∂∂", '"_dd')
vmap("∂", '"_d')
nmap("Î", '"_D')
vmap("Î", '"_D')
nmap("ç", '"_c')
nmap("çç", '"_cc')
vmap("ç", '"_c')
nmap("Ç", '"_C')
vmap("Ç", '"_C')
nmap("≈", '"_x')
vmap("≈", '"_x')
nmap("˛", '"_X')
vmap("˛", '"_X')

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

function QuickFixToggle()
  if vim.bo.buftype == 'quickfix' then
    vim.cmd("cclose")
    return
  end
  vim.cmd("copen")
end
nmap("<tab>", ":lua QuickFixToggle()<CR>")

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
function LineHome()
  local x = vim.fn.col('.')
  vim.cmd("normal! ^")
  if x == vim.fn.col('.') then
    vim.cmd("normal! 0")
  end
end
function LineZero()
  local x = vim.fn.col('.')
  vim.cmd("normal! 0")
  if x == vim.fn.col('.') then
    vim.cmd("normal! ^")
  end
end
nmap("<Home>", ":lua LineHome()<CR>")
vmap("<Home>", ":lua LineHome()<CR>")
imap("<Home>", "<C-O>:lua LineHome()<CR>")
nmap("0", ":lua LineZero()<CR>")
vmap("0", ":lua LineZero()<CR>")
function contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end
function StripTrailingWhitespaces(filetypes)
  local filetype = vim.bo.filetype
  if not contains(filetypes, filetype) then
    return
  end
  -- Preparation: save last search, and cursor position.
  local line = vim.fn.line('.')
  local column = vim.fn.col('.')
  local last_search = vim.fn.getreg('/')

  vim.cmd(":%s/\\s\\+$//e")

  -- Clean up: restore previous search history, and cursor position
  vim.fn.setreg('/', last_search)
  vim.fn.cursor(line, column)
end
augroup("stripTrailingWhitespacesPluginDetect", "BufWritePre", "<buffer>", { ':lua StripTrailingWhitespaces({ "ruby", "python", "javascript", "nix", "lua" })' })

function InNormalReplacingCursor(command)
  -- Preparation: save cursor position.
  local line = vim.fn.line('.')
  local column = vim.fn.col('.')

  vim.cmd("normal! " .. command)

  -- Clean up: restore previous cursor position
  vim.fn.cursor(line, column)
end
nmap("<Leader>==", ':lua InNormalReplacingCursor("gg=G")<CR>')
nmap("<Leader>=p", ':lua InNormalReplacingCursor("=ip")<CR>')
nmap("<Leader>=r", ':lua InNormalReplacingCursor("=ar")<CR>')

-- Select last paste/change
nmap("<Leader>v", "`[v`]")
nmap("<Leader>V", "`[V`]")

function OpenCurrentFileInGithub()
  local abs_path = vim.fn.expand('%:p')
  local file_dir = vim.fn.substitute(abs_path, '/[^/]*$', '', '')
  local git_root = vim.fn.system('cd ' .. file_dir .. '; git rev-parse --show-toplevel | tr -d "\\n"')
  local file_path = vim.fn.substitute(abs_path, git_root .. '/', '', '')
  local branch = vim.fn.system('git symbolic-ref --short -q HEAD | tr -d "\\n"')
  local git_remote = vim.fn.system('cd ' .. file_dir .. '; git remote get-url origin | tr -d "\\n"')
  local url = git_remote .. '/blob/' .. branch .. '/' .. file_path
  local first_line = vim.fn.getpos("'<")[2]
  url = url .. '#L' .. first_line
  local last_line = vim.fn.getpos("'>")[2]
  if last_line ~= first_line then
    url = url .. '-L' .. last_line
  end
  vim.fn.system('open ' .. url)
end

nmap("<Leader><Leader>g", "V:<c-u>lua OpenCurrentFileInGithub()<cr>")
xmap("<Leader><Leader>g", ":<c-u>lua OpenCurrentFileInGithub()<cr>")

nmap("<Leader>cp", ":let @* = expand('%')<cr>")
nmap("<Leader>cap", ":let @* = expand('%:p')<cr>")

vim.g.LanguageClient_serverCommands = {
  ruby = { 'bundle', 'exec', 'srb', 'tc', '--lsp' },
  sh = { 'bash-language-server', 'start' },
  yml = { 'yaml-language-server' }
}
nmap("K", "<Plug>(lcn-hover)")
nmap("gd", "<Plug>(lcn-definition)")
nmap("<Leader>ls", "<Plug>(lcn-menu)")

vim.g.ruby_indent_assignment_style = 'variable'
vim.g.ruby_indent_hanging_elements = 0

nmap("<Leader>o", "<C-o>")
nmap("<Leader>i", "<C-i>")
nmap("<Leader>r", "<C-r>")

-- Set the visual mode to line mode if the selection is multiline
-- and back to character mode if the selection is single line.
-- This is particularly useful when using the mouse to select text.
function AutoVisualLineMode()
  local multiline = vim.fn.getpos("v")[2] ~= vim.fn.getpos(".")[2]
  if vim.fn.mode() == 'v' and multiline then
    vim.cmd("normal! V")
  end
  if vim.fn.mode() == 'V' and not multiline then
    vim.cmd("normal! v")
  end
end

augroup("auto_visual_line_mode", "CursorMoved", "*", {
  ":lua AutoVisualLineMode()",
})
