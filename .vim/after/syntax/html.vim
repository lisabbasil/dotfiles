" Define certain regions
" Block math. Look for "$$[anything]$$"
syn region math start=/\$\$/ end=/\$\$/
" inline math. Look for "$[not $][anything]$"
syn match math_block '\$[^$].\{-}\$'

" Actually highlight those regions.
hi link math Special
hi link math_block Special
