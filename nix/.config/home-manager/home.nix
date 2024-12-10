{ config, pkgs, ... }:
{
  # Home Manager precisa de algumas informações sobre você e os caminhos que deve gerenciar.
  home.username = "administrador";
  home.homeDirectory = "/home/administrador";

  # Este valor determina a versão do Home Manager que sua configuração é compatível.
  # Isso ajuda a evitar quebras quando uma nova versão do Home Manager introduz mudanças incompatíveis.
  #
  # Você não deve mudar este valor, mesmo se atualizar o Home Manager. Se quiser atualizar o valor,
  # certifique-se de verificar as notas de lançamento do Home Manager.
  home.stateVersion = "24.05"; # Leia o comentário antes de mudar.

  # Definindo um overlay para substituir a versão do openvpn
  nixpkgs.overlays = [
    (final: prev: {
      openvpn = prev.openvpn.overrideAttrs (oldAttrs: rec {
        pname = "openvpn";
        version = "2.5.8"; # Versão desejada

        src = prev.fetchurl {
          url = "https://swupdate.openvpn.org/community/releases/openvpn-${version}.tar.gz";
          sha256 = "a6f315b7231d44527e65901ff646f87d7f07862c87f33531daa109fb48c53db2"; # Substitua pelo hash correto
        };
      });
    })
  ];

  # Pacotes a serem instalados
  home.packages = with pkgs; [
    # fontes
    nerd-fonts.profont
    nerd-fonts.caskaydia-mono
    nerd-fonts.jetbrains-mono

    # Pacotes de sistema
    fish
    fzf
    atuin
    fd
    bat
    ncdu
    duf
    eza
    zoxide
    stow
    git
    starship
    openvpn
    
    # Pacotes de desenvolvimento
    neovim
    cargo
    lua51Packages.luarocks
    nodejs
    ripgrep
    nil
    nixpkgs-fmt
    
    # Aplicativos gráficos
    pidgin

    # Aplicativos de Ambiente de Desktop
    wofi

    # Temas
    dracula-theme # Tema GTK2
    catppuccin-gtk # Tema GTK3/4
    libsForQt5.qt5ct # Tema QT5
  ];

  # Home Manager é muito bom em gerenciar arquivos de configuração. A principal maneira de gerenciar
  # arquivos simples é através de 'home.file'.
  home.file = {};

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

  # Deixe o Home Manager instalar e gerenciar a si mesmo.
  programs.home-manager.enable = true;

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
    font.name = "JetBrains Mono Nerd Font 11";

    gtk2.extraConfig = ''
      gtk-theme-name = "Dracula"
    '';

    gtk3.extraConfig = {
      gtk-theme-name="catppuccin-mocha-blue-standard+default";
    };

    gtk4.extraConfig = {
      gtk-theme-name="catppuccin-mocha-blue-standard+default";
    };
  };

  # Configurações do Fish shell
  programs.fish = {
    enable = true;
    
    interactiveShellInit = ''
      if status is-interactive
        set -U fish_greeting ""

        starship init fish | source

        set -gx ATUIN_NOBIND "true"
        atuin init fish | source

        # vincular ao ctrl-r no modo normal e de inserção, adicione quaisquer outras vinculações aqui também
        bind \cr _atuin_search
        bind -M insert \cr _atuin_search
        
        alias ls="eza"
        alias cd="z"

        [ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

        set -x PATH $HOME/.nix-profile/bin $HOME/.nix-profile/sbin $PATH
        thefuck --alias | source
        zoxide init fish | source
      end
    '';
  };

  # Habilitar XDG
  xdg.enable = true;
  targets.genericLinux.enable = true;

  # Configurações de aplicativos padrão
  xdg.mimeApps.defaultApplications = {
    "text/plain" = "nvim.desktop";
    "application/pdf" = "zen-alpha.desktop";
  };
}