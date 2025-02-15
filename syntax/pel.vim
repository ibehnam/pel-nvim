if exists("b:current_syntax")
  finish
endif

" ─────────────────────────────────────────────────────────────────────────
" 0) Auto‐reload syntax when you change color schemes
"    This ensures that if you do :colorscheme <something>, your custom
"    Pel syntax won’t disappear.
" ─────────────────────────────────────────────────────────────────────────
augroup pel_auto_reload
  autocmd!
  autocmd ColorScheme * if &filetype ==# 'pel' | runtime! syntax/pel.vim | endif
augroup END

" ─────────────────────────────────────────────────────────────────────────
" 1) Comments (leading semicolon)
" ─────────────────────────────────────────────────────────────────────────
syntax match pelComment /;.*$/
highlight default link pelComment Comment

" ─────────────────────────────────────────────────────────────────────────
" 2) Strings in double quotes
" ─────────────────────────────────────────────────────────────────────────
syntax match pelString /"[^"]*"/
highlight default link pelString String

" ─────────────────────────────────────────────────────────────────────────
" 3) Numeric literals (int or float, possibly negative)
" ─────────────────────────────────────────────────────────────────────────
syntax match pelNumber /\v-?\d+(\.\d+)?/
highlight default link pelNumber Number

" ─────────────────────────────────────────────────────────────────────────
" 4) Pipe operator
" ─────────────────────────────────────────────────────────────────────────
syntax match pelPipe /\|>/
highlight default link pelPipe Operator

" ─────────────────────────────────────────────────────────────────────────
" 5) Brackets and parentheses themselves as Delimiters
" ─────────────────────────────────────────────────────────────────────────
syntax match pelBracket /[\[\]]/
highlight default link pelBracket Delimiter

syntax match pelParen /[()]/
highlight default link pelParen Delimiter

" ─────────────────────────────────────────────────────────────────────────
" 6) Keywords (e.g. def, lambda) vs. builtins (e.g. print)
" ─────────────────────────────────────────────────────────────────────────
syntax keyword pelKeyword def lambda let do if for while case
highlight default link pelKeyword Keyword

syntax keyword pelBuiltin print eq map filter reduce apply
highlight default link pelBuiltin Function

" ─────────────────────────────────────────────────────────────────────────
" 7) Keys of the form :xyz
" ─────────────────────────────────────────────────────────────────────────
syntax match pelKey /:[A-Za-z_][A-Za-z0-9_]*/
highlight default link pelKey Identifier

" ─────────────────────────────────────────────────────────────────────────
" 8) Parenthesis‐based expressions
"
"    We define two regions:
"    • pelParenExpr, for everything between "(" and ")"
"    • pelBracketExpr, for everything between "[" and "]"
" 
"    Inside these are allowed to contain our tokens: comments, strings,
"    numbers, keys, pipe, builtins, keywords, etc.
"    
"    We also highlight the first symbol after "(" specially as pelFirstSymbol.
" ─────────────────────────────────────────────────────────────────────────
syntax region pelParenExpr start="(" end=")" contains=pelComment,pelString,pelNumber,pelKey,pelPipe,pelBuiltin,pelKeyword,pelFirstSymbol
highlight default link pelParenExpr None

syntax region pelBracketExpr start="\[" end="\]" contains=pelComment,pelString,pelNumber,pelKey,pelPipe,pelBuiltin,pelKeyword
highlight default link pelBracketExpr None

" 8a) The "first symbol" after "(" gets a special highlight
"     (print i) => "print" is pelFirstSymbol
"     We use a lookbehind to capture the token right after "(".
syntax match pelFirstSymbol /\v(?<=\()[ \t]*[^\ \t()]+/ contained
highlight default link pelFirstSymbol Special

" Mark that we have loaded Pel syntax
let b:current_syntax = "pel"
