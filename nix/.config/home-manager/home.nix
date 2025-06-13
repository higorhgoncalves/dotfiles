{ config, pkgs, ... }: {
  # Home Manager precisa de algumas informações sobre você e os caminhos que deve gerenciar.
  home.username = "administrador";
  home.homeDirectory = "/home/administrador";

  # Este valor determina a versão do Home Manager que sua configuração é compatível.
  # Isso ajuda a evitar quebras quando uma nova versão do Home Manager introduz mudanças incompatíveis.
  #
  # Você não deve mudar este valor, mesmo se atualizar o Home Manager. Se quiser atualizar o valor,
  # certifique-se de verificar as notas de lançamento do Home Manager.
  home.stateVersion = "25.05"; # Leia o comentário antes de mudar.

  # Deixe o Home Manager instalar e gerenciar a si mesmo.
  programs.home-manager.enable = true;

  # Definindo um overlay para substituir a versão do openvpn
  nixpkgs.overlays = [
    (final: prev: {
      openvpn = prev.openvpn.overrideAttrs (oldAttrs: rec {
        pname = "openvpn";
        version = "2.5.8"; # Versão desejada

        src = prev.fetchurl {
          url =
            "https://swupdate.openvpn.org/community/releases/openvpn-${version}.tar.gz";
          sha256 =
            "a6f315b7231d44527e65901ff646f87d7f07862c87f33531daa109fb48c53db2"; # Substitua pelo hash correto
        };
      });
    })
  ];

  # Pacotes a serem instalados
  home.packages = with pkgs; [
    # fontes
    # nerd-fonts.profont
    # nerd-fonts.caskaydia-mono
    # nerd-fonts.jetbrains-mono

    # Pacotes de sistema
    fish
    # fzf
    # atuin
    # fd
    # bat
    # ncdu
    # duf
    # eza
    # zoxide
    # stow
    # git
    starship
    # openvpn

    # Pacotes de desenvolvimento
    # neovim
    # cargo
    # lua51Packages.luarocks
    # # nodejs
    # ripgrep
    # nixd
    # nixfmt-classic

    # Pacotes VSCode
    # vscode
    # vscode-extensions.catppuccin.catppuccin-vsc
    # vscode-extensions.catppuccin.catppuccin-vsc-icons
    # vscode-extensions.devsense.phptools-vscode
    # vscode-extensions.xdebug.php-debug
    # vscode-extensions.github.copilot
    # vscode-extensions.github.copilot-chat
    # vscode-extensions.eamodio.gitlens
    # vscode-extensions.ecmel.vscode-html-css

    # Aplicativos gráficos
    # pidgin

    # Aplicativos de Ambiente de Desktop
    # wofi

    # Temas
    dracula-theme # Tema GTK2
    catppuccin-gtk # Tema GTK3/4
    libsForQt5.qt5ct # Tema QT5
  ];

  # Home Manager é muito bom em gerenciar arquivos de configuração. A principal maneira de gerenciar
  # arquivos simples é através de 'home.file'.
  home.file = {
    # ".config/kitty/kitty.con" = {
    #   text = ''
    #     # Shell Styling
    #     shell_integration no-cursor
    #     cursor_shape underline

    #     # Window Style
    #     # wayland_titlebar_color background
    #     hide_window_decorations yes

    #     # Hyprland :)
    #     linux_display_server wayland

    #     background_opacity 0.75
    #     adjust_line_height 120%

    #     # BEGIN_KITTY_FONTS
    #     font_family      family="JetBrains Mono NL"
    #     bold_font        auto
    #     italic_font      auto
    #     bold_italic_font auto
    #     # END_KITTY_FONTS

    #     # BEGIN_KITTY_THEME
    #     # Catppuccin-Mocha
    #     include current-theme.conf
    #     # END_KITTY_THEME
    #   '';
    # };
  };

  # Home Manager também pode gerenciar suas variáveis de ambiente através de 'home.sessionVariables'.
  # Se você não quiser gerenciar seu shell através do Home Manager, então você deve manualmente
  # adicionar 'hm-session-vars.sh' localizado em
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # ou
  #
  #  /etc/profiles/per-user/administrador/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_STYLE_OVERRIDE = "Fusion";
  };

  # Configurações do Git
  programs.git = {
    enable = true;
    userName = "Higor Henrique Prata Gonçalves";
    userEmail = "higor.henrique@legisweb.com.br";
  };

  # Configurações do GTK
  gtk = {
    enable = true;
    cursorTheme.name = "Bibata-Modern-Classic";
    iconTheme.name = "Papirus-Dark";
    font.name = "JetBrains Mono NL 11";

    gtk2.extraConfig = ''
      gtk-theme-name = "Dracula"
    '';

    gtk3.extraConfig = {
      gtk-theme-name = "catppuccin-mocha-blue-standard+default";
    };

    gtk4.extraConfig = {
      gtk-theme-name = "catppuccin-mocha-blue-standard+default";
    };
  };

  # Configurações do Fish shell
  programs.fish = {
    enable = true;
    shellAliases = {
      # Definindo aliases para o Fish shell
      ls = "eza";
      cd = "z";
      gnome-control-center =
        "XDG_CURRENT_DESKTOP=Gnome /usr/bin/gnome-control-center";
      fzfpass = ''
        read -s -P "Digite a senha para KeePassXC: " keepasswd; and \
        printf "%s\n" "$keepasswd" | keepassxc-cli ls "Legisweb.kdbx" | \
        fzf --multi --reverse --preview="echo {}" --preview-window=down,3,wrap | \
        xargs -I {} sh -c "printf '%s\n' '$keepasswd' | keepassxc-cli show -q 'Legisweb.kdbx' '{}' -a Password"\
      '';
      tmux-restore =
        "tmux new -d -t temp && tmux run-shell ~/.tmux/plugins/tmux-resurrect/scripts/restore.sh && tmux kill-session -t temp && tmux attach";
      fzftop = ''
        ps aux | \
        fzf --multi --reverse --bind 'ctrl-r:reload(ps aux)' --header='Press CTRL-R to reload' --header-lines=2 --preview='echo {}' --preview-window=down,3,wrap | \
        awk '{print $2}' | \
        xargs kill -9\
      '';
    };
    interactiveShellInit = ''
      if status is-interactive
        set -U fish_greeting ""

        starship init fish | source

        set -gx ATUIN_NOBIND "true"
        atuin init fish | source
        # gh fish source | source
        gh completion -s fish > ~/.config/fish/completions/gh.fish

        fzf --fish | FZF_CTRL_R_COMMAND= source

        # vincular ao ctrl-r no modo normal e de inserção, adicione quaisquer outras vinculações aqui também
        bind \cr _atuin_search
        bind -M insert \cr _atuin_search

        [ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

        set -x PATH $HOME/.nix-profile/bin $HOME/.nix-profile/sbin $PATH
        set -x PATH $HOME/.config/herd-lite/bin $PATH

        set -x COMPOSE_BAKE true
        set -x TERMINAL /usr/bin/kitty

        set -x GOOGLE_SEARCH_ENGINE_ID "956ead57766404115"
        set -x GOOGLE_SEARCH_API_KEY "AIzaSyAMCWGpnuXzsBING56M_ryNuQWpI8d7G1Q"

        set -x TAVILY_API_KEY "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"

        thefuck --alias | source
        zoxide init fish | source

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
          printf "%s\n" "$keepasswd" | keepassxc-cli ls "$db_path" | \
          fzf --multi --reverse --preview="echo {}" --preview-window=down,3,wrap | \
          while read -l entry
            printf "%s\n" "$keepasswd" | keepassxc-cli show -q "$db_path" "$entry" -a Password | tr -d '\n' | wl-copy
            echo "Senha copiada para clipboard: $entry"
          end
        end
      end
    '';
  };

  # Habilitar XDG
  # xdg.enable = true;
  # targets.genericLinux.enable = true;

  # Configurações de aplicativos padrão
  xdg.mimeApps.defaultApplications = {
    "text/plain" = "nvim.desktop";
    "application/pdf" = "firefox.desktop";
  };
}
