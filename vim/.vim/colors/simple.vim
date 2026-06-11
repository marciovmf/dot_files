"
" marciovmf simple_dark vim theme
"
hi clear
syntax reset
let g:colors_name = "simple_dark"
set background=dark
set t_Co=256
hi Normal guifg=#FFFFFF ctermbg=NONE guibg=#696969 gui=NONE

hi cssClassName guifg=#eeeeee guibg=NONE
hi cssClassNameDot guifg=#eeeeee guibg=NONE
hi cssIncludeKeyword guifg=#cccccc guibg=NONE
hi cssAttr guifg=#cccccc guibg=NONE
hi cssIdentifier guifg=#cccccc guibg=NONE
hi cssImportant guifg=#cccccc guibg=NONE
hi cssColor guifg=#ffffff guibg=NONE

hi DiffText guifg=#cccccc guibg=NONE
hi ErrorMsg guifg=#cccccc guibg=NONE
hi WarningMsg guifg=#cccccc guibg=NONE
hi PreProc guifg=#cccccc guibg=NONE
hi Exception guifg=#cccccc guibg=NONE
hi Error guifg=#cccccc guibg=NONE
hi DiffDelete guifg=#cccccc guibg=NONE
hi GitGutterDelete guifg=#cccccc guibg=NONE
hi GitGutterChangeDelete guifg=#cccccc guibg=NONE
hi Identifier guifg=#FFFFFF guibg=NONE
hi Repeat guifg=#cccccc guibg=NONE
hi DiffAdd guifg=#cccccc guibg=NONE
hi GitGutterAdd guifg=#cccccc guibg=NONE
hi IncSearch guifg=#ffffff guibg=NONE
hi Title guifg=#ffffff guibg=NONE
hi Debug guifg=#ffffff guibg=NONE
hi SpecialChar guifg=#ffffff guibg=NONE
hi Todo guifg=#ffffff guibg=NONE
hi Special guifg=#ffffff guibg=NONE
hi Label guifg=#ffffff guibg=NONE
hi Delimiter guifg=#ffffff guibg=NONE
hi CursorLineNR guifg=#ffffff guibg=NONE
hi Define guifg=#ffffff guibg=NONE gui=bold
hi MoreMsg guifg=#ffffff guibg=NONE
hi Tag guifg=#ffffff guibg=NONE 
hi MatchParen guifg=#ffffff guibg=NONE
hi DiffChange guifg=#ffffff guibg=NONE
hi GitGutterChange guifg=#ffffff guibg=NONE
hi Function guifg=#FFFFFF guibg=NONE gui=bold
hi Directory guifg=#eeeeee guibg=NONE
hi markdownLinkText guifg=#eeeeee guibg=NONE
hi javaScriptBoolean guifg=#eeeeee guibg=NONE
hi Storage guifg=#eeeeee guibg=NONE

hi Keyword guifg=#FFFFFF guibg=NONE gui=bold
hi Conditional guifg=#FFFFFF guibg=NONE
hi Include guifg=#FFFFFF guibg=NONE
hi Number guifg=#FFFFC0 guibg=NONE
"hi Constant guifg=#9DE36A  guibg=NONE
hi Constant guifg=#FFFFFF  guibg=NONE gui=bold
hi Statement guifg=#FFFFFF guibg=NONE
hi PreCondit guifg=#FFFFFF guibg=NONE
hi Macro guifg=#FFFFFF guibg=NONE gui=bold
"hi Macro guifg=#FFD840 guibg=NONE
hi Operator guifg=#BDEFF6 guibg=NONE
"hi Type guifg=#BDEFF6 guibg=NONE
hi Type guifg=#C4F8FF guibg=NONE


hi MatchParen cterm=bold guifg=#2BC6DF gui=bold


hi String guifg=#60A9FA guibg=NONE gui=italic

hi PmenuSel guifg=#ffffff guibg=#454545
hi PMenu guifg=#cccccc guibg=NONE

hi SignColumn guibg=#696969
hi Title guifg=#ffffff
hi LineNr guifg=#999999 guibg=#696969
hi NonText guifg=#f8e71c guibg=#696969
hi Comment guifg=#ADB2A0

hi SpecialComment guifg=#f8e71c guibg=NONE
hi CursorLine guibg=#0000DD
"hi CursorLine guibg=#5555BB
hi TabLineFill gui=NONE guibg=#454545
hi TabLine guifg=#999999 guibg=#454545 gui=NONE
hi StatusLine gui=bold guibg=#454545 guifg=#ffffff
hi StatusLineNC gui=NONE guibg=#696969 guifg=#ffffff
hi Search guibg=#f8e71c guifg=#ffffff
hi VertSplit gui=NONE guifg=#454545 guibg=NONE
"hi Visual gui=NONE guibg=#454545
hi Visual gui=NONE guibg=#0000DD
