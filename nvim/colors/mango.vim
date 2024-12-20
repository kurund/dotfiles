" Name: mango
" Description: "mango" stands for my favorite fruit :)
" Author: Kurund Jalmi ( This is inspired by Industry vim color scheme)

set background=dark
hi clear
let g:colors_name = "mango"
set t_Co=256

hi Normal guifg=#dadada guibg=#000000 gui=NONE cterm=NONE
hi EndOfBuffer guifg=#444444 guibg=#000000 gui=NONE cterm=NONE
hi StatusLine guifg=#000000 guibg=#dadada gui=bold cterm=bold
hi StatusLineNC guifg=#000000 guibg=#6c6c6c gui=NONE cterm=NONE
hi StatusLineTerm guifg=#000000 guibg=#EB5757 gui=bold cterm=bold
hi StatusLineTermNC guifg=#000000 guibg=#5fd75f gui=NONE cterm=NONE
hi VertSplit guifg=#000000 guibg=#6c6c6c gui=NONE cterm=NONE
hi Pmenu guifg=#dadada guibg=#000000 gui=NONE cterm=NONE
hi PmenuSel guifg=#000000 guibg=#ffff00 gui=NONE cterm=NONE
hi PmenuSbar guifg=NONE guibg=#000000 gui=NONE cterm=NONE
hi PmenuThumb guifg=NONE guibg=#6c6c6c gui=NONE cterm=NONE
hi TabLine guifg=#dadada guibg=#444444 gui=NONE cterm=NONE
hi TabLineFill guifg=NONE guibg=#6c6c6c gui=NONE cterm=NONE
hi TabLineSel guifg=#ffffff guibg=#000000 gui=bold cterm=bold
hi ToolbarButton guifg=#dadada guibg=#6c6c6c gui=bold cterm=bold
hi ToolbarLine guifg=NONE guibg=#303030 gui=NONE cterm=NONE
hi NonText guifg=#02b7e4 guibg=NONE gui=NONE cterm=NONE
hi SpecialKey guifg=#02b7e4 guibg=NONE gui=NONE cterm=NONE
hi Folded guifg=#02b7e4 guibg=#303030 gui=NONE cterm=NONE
hi Visual guifg=#dadada guibg=#6c6c6c gui=NONE cterm=NONE
hi CursorLine guifg=NONE guibg=#6c6c6c gui=NONE cterm=NONE
hi CursorColumn guifg=NONE guibg=#6c6c6c gui=NONE cterm=NONE
hi CursorLineNr guifg=#ffff00 guibg=NONE gui=bold cterm=bold
hi ColorColumn guifg=NONE guibg=#444444 gui=NONE cterm=NONE
hi QuickFixLine guifg=#000000 guibg=#fabf46 gui=NONE cterm=NONE
hi VisualNOS guifg=#dadada guibg=#6c6c6c gui=NONE cterm=NONE
hi LineNr guifg=#ffff00 guibg=NONE gui=NONE cterm=NONE
hi FoldColumn guifg=#02b7e4 guibg=NONE gui=NONE cterm=NONE
hi SignColumn guifg=#02b7e4 guibg=NONE gui=NONE cterm=NONE
hi Underlined guifg=#87afff guibg=NONE gui=underline cterm=underline
hi Error guifg=#ffffff guibg=#ff0000 gui=NONE cterm=NONE
hi ErrorMsg guifg=#ffffff guibg=#ff0000 gui=NONE cterm=NONE
hi ModeMsg guifg=#ffffff guibg=NONE gui=bold cterm=bold
hi WarningMsg guifg=#ff0000 guibg=NONE gui=bold cterm=bold
hi MoreMsg guifg=#5fd75f guibg=NONE gui=bold cterm=bold
hi Question guifg=#EB5757 guibg=NONE gui=bold cterm=bold
hi Todo guifg=#005fff guibg=#ffff00 gui=NONE cterm=NONE
hi MatchParen guifg=#303030 guibg=#afaf00 gui=NONE cterm=NONE
hi Search guifg=#000000 guibg=#ffff00 gui=NONE cterm=NONE
hi IncSearch guifg=#000000 guibg=#EB5757 gui=NONE cterm=NONE
hi WildMenu guifg=#000000 guibg=#ffff00 gui=NONE cterm=NONE
hi Cursor guifg=#000000 guibg=#dadada gui=NONE cterm=NONE
hi lCursor guifg=#000000 guibg=#ff0000 gui=NONE cterm=NONE
hi SpellBad guifg=#ff0000 guibg=NONE guisp=#ff0000 gui=undercurl cterm=underline
hi SpellCap guifg=#005fff guibg=NONE guisp=#005fff gui=undercurl cterm=underline
hi SpellLocal guifg=#fabf46 guibg=NONE guisp=#fabf46 gui=undercurl cterm=underline
hi SpellRare guifg=#EB5757 guibg=NONE guisp=#EB5757 gui=undercurl cterm=underline
hi Comment guifg=#02b7e4 guibg=NONE gui=NONE cterm=NONE
hi Identifier guifg=#fabf46 guibg=NONE gui=NONE cterm=NONE
hi Function guifg=#EB5757 guibg=NONE gui=NONE cterm=NONE
hi Statement guifg=#ffffff guibg=NONE gui=bold cterm=bold
hi Constant guifg=#00ffff guibg=NONE gui=NONE cterm=NONE
hi PreProc guifg=#ffff00 guibg=NONE gui=NONE cterm=NONE
hi Type guifg=#EB5757 guibg=NONE gui=bold cterm=bold
hi Special guifg=#c675ef guibg=NONE gui=NONE cterm=NONE
hi Delimiter guifg=#ffff00 guibg=NONE gui=NONE cterm=NONE
hi Directory guifg=#00ffff guibg=NONE gui=NONE cterm=NONE
hi Conceal guifg=#6c6c6c guibg=NONE gui=NONE cterm=NONE
hi Ignore guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Title guifg=#fabf46 guibg=NONE gui=bold cterm=bold
hi! link Terminal Normal
hi! link LineNrAbove LineNr
hi! link LineNrBelow LineNr
hi! link CurSearch Search
hi! link CursorLineFold CursorLine
hi! link CursorLineSign CursorLine
hi! link MessageWindow Pmenu
hi! link PopupNotification Todo
hi DiffAdd guifg=#ffffff guibg=#5f875f gui=NONE cterm=NONE
hi DiffChange guifg=#ffffff guibg=#5f87af gui=NONE cterm=NONE
hi DiffText guifg=#000000 guibg=#c6c6c6 gui=NONE cterm=NONE
hi DiffDelete guifg=#ffffff guibg=#af5faf gui=NONE cterm=NONE

