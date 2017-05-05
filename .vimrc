syntax on
set ruler

command -range Fixup <line1>,<line2>s/^pick /fixup /
map f :Fixup<CR>
