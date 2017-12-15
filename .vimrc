syntax on
set ruler

"Use <f> on a single line or a multi-line visual select to change rebase pick lines to fixup
command -range Fixup <line1>,<line2>s/^pick /fixup /
map f :Fixup<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
