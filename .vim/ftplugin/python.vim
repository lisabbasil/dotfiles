""" Set logging level
nnoremap <leader>lo5 mz :g/logging\.basicConfig/s/\(level=logging\.\)[^ )]*/\1CRITICAL/ <CR> `z
nnoremap <leader>lo4 mz :g/logging\.basicConfig/s/\(level=logging\.\)[^ )]*/\1ERROR/ <CR> `z
nnoremap <leader>lo3 mz :g/logging\.basicConfig/s/\(level=logging\.\)[^ )]*/\1WARNING/ <CR> `z
nnoremap <leader>lo2 mz :g/logging\.basicConfig/s/\(level=logging\.\)[^ )]*/\1INFO/ <CR> `z
nnoremap <leader>lo1 mz :g/logging\.basicConfig/s/\(level=logging\.\)[^ )]*/\1DEBUG/ <CR> `z

" Linebreak on 79 characters (pep8 conform)
set tw=79

" Autopep, yeah!
nnoremap <leader>pep :!pep8 --first --show-source --show-pep8 --statistics "%" <CR>
