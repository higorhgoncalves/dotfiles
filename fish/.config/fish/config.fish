# Aliases
alias cd z
alias fzftop 'ps aux | \
    fzf --multi --reverse --bind '\''ctrl-r:reload(ps aux)'\'' --header='\''Press CTRL-R to reload'\'' --header-lines=2 --preview='\''echo {}'\'' --preview-window=down,3,wrap | \
    awk '\''{print $2}'\'' | \
    xargs kill -9\
    '
alias gnome-control-center 'XDG_CURRENT_DESKTOP=Gnome /usr/bin/gnome-control-center'
alias ls eza
alias tmux-restore 'tmux new -d -t temp && tmux run-shell ~/.tmux/plugins/tmux-resurrect/scripts/restore.sh && tmux kill-session -t temp && tmux attach'

# Functions
function y
    set -l cwd_file (command cat -- "$argv[1]")
    if test -n "$cwd_file"
        builtin cd -- "$cwd_file"
    else
        echo "Erro: Caminho do diretório não encontrado no arquivo."
    end
end

function fzfpass
    # Verificar se as dependências estão instaladas
    if not command -v fzf >/dev/null
        echo "Erro: fzf não está instalado"
        return 1
    end

    if not command -v fd >/dev/null
        echo "Erro: fd não está instalado"
        return 1
    end

    if not command -v keepassxc-cli >/dev/null
        echo "Erro: keepassxc-cli não está instalado"
        return 1
    end

    if not command -v wl-copy >/dev/null
        echo "Erro: wl-clipboard não está instalado"
        return 1
    end

    # Selecionar banco de dados
    set db_path (fd ".kdbx\$" $HOME | fzf --prompt="Selecione o banco de dados: ")

    if test -z "$db_path"
        echo "Nenhum banco selecionado"
        return 1
    end

    # Ler senha
    read -s -P "Digite a senha para KeePassXC: " keepasswd

    # Selecionar entrada e copiar senha
    printf "%s\n" "$keepasswd" | keepassxc-cli ls "$db_path" | fzf --multi --reverse --preview="echo {}" --preview-window=down,3,wrap | \
    while read -l entry
        printf "%s\n" "$keepasswd" | keepassxc-cli show -q "$db_path" "$entry" -a Password | tr -d '\n' | wl-copy
        echo "Senha copiada para clipboard: $entry"
    end
end


# Interactive shell initialisation
if status is-interactive
    set -U fish_greeting ""

    fzf --fish | FZF_CTRL_R_COMMAND= source

    [ "$TERM" = xterm-kitty ] && alias ssh="kitty +kitten ssh"

    # Set environment variables
    set -x PATH $HOME/.nix-profile/bin $HOME/.nix-profile/sbin $PATH
    set -x PATH $HOME/.config/herd-lite/bin $PATH

    set -x COMPOSE_BAKE true
    set -x TERMINAL /usr/bin/kitty

    set -x EDITOR nvim

    set -x GOOGLE_SEARCH_ENGINE_ID 956ead57766404115
    set -x GOOGLE_SEARCH_API_KEY AIzaSyAMCWGpnuXzsBING56M_ryNuQWpI8d7G1Q
    set -x TAVILY_API_KEY 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

    set -Ux EZA_ICONS_AUTO 1

    thefuck --alias | source
    zoxide init fish | source
    atuin init fish --disable-up-arrow | source
    gh fish source | source
    starship init fish | source
end
