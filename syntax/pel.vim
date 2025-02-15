if exists("b:current_syntax")
  finish
endif

" 1. Match semicolon comments
syntax match pelComment /;.*$/
highlight link pelComment Comment

" 2. Match double‐quoted strings
syntax match pelString /"[^"]*"/
highlight link pelString String

" 3. Match numbers (int or float, possibly negative)
syntax match pelNumber /\v-?\d+(\.\d+)?/
highlight link pelNumber Number

" 4. Highlight pipes (|>)
syntax match pelPipe /\|>/
highlight link pelPipe Operator

" 5. Highlight brackets as delimiters
syntax match pelBracket /[[\]]/
highlight link pelBracket Delimiter
" Similarly for parentheses if you want:
syntax match pelParen /[()]/
highlight link pelParen Delimiter

" 6. Highlight “keys” that start with a colon, e.g. :x, :foo
syntax match pelKey /:[A-Za-z0-9_]+/
highlight link pelKey Identifier

" 7. Some example keywords or builtins in Pel:
syntax keyword pelKeyword def lambda do if for while case let
highlight link pelKeyword Keyword

" 8. Done
let b:current_syntax = "pel"
