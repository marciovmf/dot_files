" =========================
"
" A Vim colorscheme with the goal to mimic the colorscheme of
" Jonathan Blow emacs theme.
" 
" Name    : jblow
" Author  : Niklas Schultz
" License : MIT
"
" =========================
"
set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "jblow"

hi Normal                  gui=NONE guifg=#d2b58d guibg=#062628

hi Visual				   gui=NONE guifg=#FFFFFF guibg=#0000FF 
hi VisualNOS               gui=NONE guifg=#BBBBBB guibg=#062628

hi Comment                 gui=NONE guifg=#5ebd55 guibg=#062628
hi SpecialComment          gui=NONE guifg=#5ebd55 guibg=#062628
hi Keyword                 gui=NONE guifg=#FFFFFF guibg=#062628
hi Identifier              gui=NONE guifg=#8FE1C8 guibg=#062628
hi PreProc                 gui=NONE guifg=#FFFFFF guibg=#062628
hi Function                gui=NONE guifg=#d4d4d4 guibg=#062628
hi Label                   gui=NONE guifg=#FFFFFF guibg=#062628
hi Statement               gui=NONE guifg=#FFFFFF guibg=#062628
hi Type                    gui=NONE guifg=#8FE1C8 guibg=#062628
hi Include                 gui=NONE guifg=#86E08F guibg=#062628
hi Define                  gui=NONE guifg=#86E08F guibg=#062628
hi Macro                   gui=NONE guifg=#86E08F guibg=#062628
hi PreCondit               gui=NONE guifg=#FFFFFF guibg=#062628
hi StorageClass            gui=NONE guifg=#FFFFFF guibg=#062628
hi Structure               gui=NONE guifg=#FFFFFF guibg=#062628
hi Typedef                 gui=NONE guifg=#FFFFFF guibg=#062628
hi Operator                gui=NONE guifg=#FFFFFF guibg=#062628
hi Conditional             gui=NONE guifg=#FFFFFF guibg=#062628
hi Number                  gui=NONE guifg=#8FE1C8 guibg=#062628
hi Constant                gui=NONE guifg=#8FE1C8 guibg=#062628
hi Boolean                 gui=NONE guifg=#8FE1C8 guibg=#062628
hi Float                   gui=NONE guifg=#8FE1C8 guibg=#062628
hi Repeat                  gui=NONE guifg=#FFFFFF guibg=#062628
hi Exception               gui=NONE guifg=#FFFFFF guibg=#062628
hi String                  gui=NONE guifg=#2ec09c guibg=#062628
hi Error                   gui=NONE guifg=#FF0000 guibg=#062628

hi NonText  		       gui=NONE guifg=#d2b58d guibg=#062628
hi Character               gui=NONE guifg=#d2b58d guibg=#062628
hi SpecialChar             gui=NONE guifg=#d2b58d guibg=#062628
hi Tag                     gui=NONE guifg=#d2b58d guibg=#062628
hi Delimiter               gui=NONE guifg=#d2b58d guibg=#062628

" NOTE(nschultz): messages
hi WarningMsg              gui=NONE guifg=#d2b58d guibg=#062628
hi ErrorMsg 		       gui=NONE guifg=#FF0000 guibg=#062628
hi MoreMsg 		           gui=NONE guifg=#d2b58d guibg=#062628
hi ModeMsg                 gui=NONE guifg=#d2b58d guibg=#062628

" NOTE(nschultz): Tabbar
hi TabLine       		   gui=NONE guifg=#d2b58d guibg=#062628
hi TabLineSel   		   gui=NONE guifg=#d2b58d guibg=#062628
hi TabLineFill  		   gui=NONE guifg=#d2b58d guibg=#062628

" NOTE(nschultz): Vertical split bar
hi VertSplit               gui=NONE guifg=#FFFFFF guibg=#FFFFFF

" NOTE(nschultz): wildmenu (window when using tab completion)
hi WildMenu                gui=bold guifg=#000000 guibg=#d2b58d

" NOTE(nschultz): Statusline (don't confuse with 'wildmenu')
hi StatusLine              gui=NONE guifg=#000000 guibg=#d2b58d
hi StatusLineNC            gui=NONE guifg=#000000 guibg=#CCCCCC
hi StatusLineTerm          gui=NONE guifg=#000000 guibg=#d2b58d
hi StatusLineTermNC        gui=NONE guifg=#000000 guibg=#CCCCCC

" NOTE(nschultz): Auto-complete popup window
hi Pmenu      		       gui=NONE guifg=#d2b58d guibg=#062628
hi PmenuSel   		       gui=NONE guifg=#d2b58d guibg=#0F0F0F
hi PmenuSbar 		       gui=NONE guifg=#d2b58d guibg=#062628
hi PmenuThumb 		       gui=NONE guifg=#d2b58d guibg=#062628

" NOTE(nschultz): 'todo/note' keywords
hi Todo                    gui=NONE guifg=#5ebd55 guibg=#062628
hi Note                    gui=NONE guifg=#5ebd55 guibg=#062628

" NOTE(nschultz): Cursor
hi Cursor                  gui=NONE guifg=#000000 guibg=#5ebd55
hi iCursor                 gui=NONE guifg=#000000 guibg=#5eff55
hi lCursor                 gui=NONE guifg=#000000 guibg=#062628
hi CursorLine              gui=NONE guifg=NONE    guibg=#111111
hi CursorColumn            gui=NONE guifg=#d2b58d guibg=#062628

" NOTE(nschultz): The end of the buffer
hi EndOfBuffer 		       gui=NONE guifg=#d2b58d guibg=#062628

" NOTE(nschultz): Searching
hi Search 	     	       gui=NONE guifg=#d2b58d guibg=#062628
hi IncSearch 		       gui=NONE guifg=#d2b58d guibg=#062628

" NOTE(nschultz): Diff (e.g vertical diffsplit)
hi DiffAdd                 gui=NONE guifg=#d2b58d guibg=#062628
hi DiffChange              gui=NONE guifg=#d2b58d guibg=#062628
hi DiffDelete              gui=NONE guifg=#d2b58d guibg=#062628
hi DiffText  		       gui=NONE guifg=#d2b58d guibg=#062628

" NOTE(nschultz): Line numbers
hi LineNr 	               gui=NONE guifg=#d2b58d guibg=#062628
hi LineNrAbove             gui=NONE guifg=#d2b58d guibg=#062628
hi LineNrBelow             gui=NONE guifg=#d2b58d guibg=#062628
hi CursorLineNr            gui=NONE guifg=#d2b58d guibg=#062628

" NOTE(nschultz): Matching bracket
hi MatchParen              gui=NONE guifg=#FFFFFF guibg=#062628

" NOTE(nschultz): Folding (zf)
hi Folded                  gui=NONE guifg=#d2b58d guibg=#062628
hi FoldColumn              gui=NONE guifg=#d2b58d guibg=#062628

" NOTE(nschultz): Other...
hi SpecialKey 		       gui=NONE guifg=#d2b58d guibg=#062628
hi Special                 gui=NONE guifg=#d2b58d guibg=#062628
hi ToolbarLine             gui=NONE guifg=#d2b58d guibg=#062628
hi ToolbarButton           gui=NONE guifg=#d2b58d guibg=#062628
hi Directory 		       gui=NONE guifg=#d2b58d guibg=#062628
hi Question                gui=NONE guifg=#d2b58d guibg=#062628
hi Title                   gui=NONE guifg=#d2b58d guibg=#062628
hi SignColumn 		       gui=NONE guifg=#d2b58d guibg=#062628
hi Conceal   		       gui=NONE guifg=#d2b58d guibg=#062628
hi SpellBad 		       gui=NONE guifg=#d2b58d guibg=#062628
hi SpellCap   		       gui=NONE guifg=#d2b58d guibg=#062628
hi SpellRare 		       gui=NONE guifg=#d2b58d guibg=#062628
hi SpellLocal 		       gui=NONE guifg=#d2b58d guibg=#062628
hi ColorColumn             gui=NONE guifg=#d2b58d guibg=#062628
hi QuickFixLine            gui=NONE guifg=#d2b58d guibg=#062628
hi Underlined              gui=NONE guifg=#d2b58d guibg=#062628
hi Ignore                  gui=NONE guifg=#d2b58d guibg=#062628
hi Debug                   gui=NONE guifg=#d2b58d guibg=#062628
hi multiple_cursors_curso  gui=NONE guifg=#d2b58d guibg=#062628
hi multiple_cursors_visual gui=NONE guifg=#d2b58d guibg=#062628
hi markdownH1              gui=NONE guifg=#d2b58d guibg=#062628
hi markdownH2              gui=NONE guifg=#d2b58d guibg=#062628
hi markdownH3              gui=NONE guifg=#d2b58d guibg=#062628
hi markdownLinkText        gui=NONE guifg=#d2b58d guibg=#062628
