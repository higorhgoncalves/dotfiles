{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "administrador";
  home.homeDirectory = "/home/administrador";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

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

  home.packages = with pkgs; [
    # fonts
    nerd-fonts.profont
    nerd-fonts.caskaydia-mono
    nerd-fonts.jetbrains-mono

    # terminal
    # kitty
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
    neovim
    openvpn
    cargo
    lua51Packages.luarocks
    nodejs
    ripgrep
    nil
    nixpkgs-fmt

    #colorscheme
    catppuccin-gtk # Tema GTK
    libsForQt5.qt5ct

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/administrador/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_STYLE_OVERRIDE = "Fusion";
  };

  #  home.activation = {
  #    afterSwitch = ''
  #      stow -d ~/dotfiles -t ~ config_name
  #    '';
  #  };

  # homeConfigurations = {

  # }

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Higor Henrique Prata Gonçalves";
    userEmail = "higor.henrique@legisweb.com.br";
    # aliases = {
    #   pu = "push";
    #   co = "checkout";
    #   cm = "commit";
    # };
  };


  gtk = {
    enable = true;
    theme.name = "catppuccin-mocha-blue-standard+default";
    cursorTheme.name = "Bibata-Modern-Classic";
    iconTheme.name = "Papirus-Dark";
    font.name = "JetBrains Mono Nerd Font 11";
    # font = "JetBrains Mono Nerd Font 11";
  };

  # home.file.".gtkrc-2.0".text = ''
  #   gtk-theme-name="Adwaita-dark"
  # '';

  xdg.mimeApps.defaultApplications = {
    "text/plain" = "nvim.desktop";
    "application/pdf" = "zen-alpha.desktop";
    # "image/*" = "gthumb.desktop";
    # "video/*" = "vlc.desktop";
    # "audio/*" = "vlc.desktop";
  };

  programs.fish = {
    enable = true;
    
    interactiveShellInit = ''
      if status is-interactive
        set -U fish_greeting ""

        starship init fish | source

        set -gx ATUIN_NOBIND "true"
        atuin init fish | source

        # bind to ctrl-r in normal and insert mode, add any other bindings you want here too
        bind \cr _atuin_search
        bind -M insert \cr _atuin_search
        
        alias ls="eza"
        alias cd="z"

        [ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

        thefuck --alias | source
        zoxide init fish | source
      end
    '';
    
  };


  # '';
  # envExtra = {
  #   # # You can set environment variables that will be available in your shell
  #   # # sessions. For example, this adds a 'MY_VAR' environment variable:
  #   # MY_VAR = "Hello, ${config.home.username}!";
  #   # 
  #   # # You can also set the PATH environment variable. This will be prepended to
  #   # # the existing PATH.
  #   # PATH = "${pkgs.hello}/bin";
  #   # 
  #   # # You can also append to the PATH environment variable.
  #   # PATH = "${pkgs.hello}/bin${config.envExtra.PATH}";
  #   # 
  #   # # You
  #   # # can also set the MANPATH environment variable. This will be prepended to
  #   # # the existing MANPATH.
  #   # MANPATH = "${pkgs.hello}/share
  # };
}
