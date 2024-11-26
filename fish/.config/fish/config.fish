if status is-interactive
    # Commands to run in interactive sessions can go here
    set -U fish_greeting ""

    starship init fish | source

    set -gx ATUIN_NOBIND "true"
    atuin init fish | source

    # bind to ctrl-r in normal and insert mode, add any other bindings you want here too
    bind \cr _atuin_search
    bind -M insert \cr _atuin_search
    
    alias ls='eza'

    alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
    alias nvim-lazyvim='NVIM_APPNAME="nvim-lazyvim" nvim'

    thefuck --alias | source
    zoxide init fish | source
end
