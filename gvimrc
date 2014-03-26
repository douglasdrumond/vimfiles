if has("gui_macvim")
    macmenu &File.New\ Tab key=<nop>
    "set background=light
    "set background=dark
    "colorscheme solarized
    "set guifont=Letter\ Gothic\ Std:h15
    "set guifont=Ubuntu\ Mono:h16
    "set guifont=Anonymous\ Pro:h16
    set guifont=Source\ Code\ Pro:h16
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
