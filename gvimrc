if has("gui_macvim")
    macmenu &File.New\ Tab key=<nop>
    "set background=light
    "set background=dark
    "colorscheme solarized
    "set guifont=Letter\ Gothic\ Std:h15
    "set guifont=Ubuntu\ Mono:h16
    "set guifont=Anonymous\ Pro:h16
    set guifont=Source\ Code\ Pro:h12
    "set guifont=Inconsolata:h16
    set linespace=3
    set transparency=8
    " make Mac's Option key behave as the Meta key
    "set macmeta

    " key binding for Command-T to behave properly
    " uncomment to replace the Mac Command-T key to Command-T plugin
    map <D-t> :CommandT<CR>
else
    set background=light
    set guifont=Ubuntu\ Mono\ 12
endif
colorscheme zenburn

let g:writeroom = 0
let g:transparency = &transparency
function! WriteRoom()
   if has("gui_running")
      if g:writeroom == 0
         let g:writeroom = 1
         set columns=80
         set fullscreen
         set linebreak
         set nocursorline
         set nolist
         set nonumber
         set noshowmode
         "set rulerformat=%{strftime('%b %e %I:%M %p')}
         set transparency=0
         hi NonText guifg=bg
      else
         let g:writeroom = 0
         set cursorline
         set list
         set nofullscreen
         set nolinebreak
         set number
         set rulerformat=
         set showmode
         let &transparency=g:transparency
         hi clear
      endif
   endif
endfunction

nmap gw :exe WriteRoom()<cr>
imap <leader>w <esc>:exe WriteRoom()<cr>i
