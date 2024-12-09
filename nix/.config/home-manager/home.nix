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
  
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # You can install some extra packages in your user environment by listing
    # fonts
    pkgs.nerd-fonts.profont
    pkgs.nerd-fonts.caskaydia-mono
    pkgs.nerd-fonts.jetbrains-mono

    # terminal
    # pkgs.kitty
    pkgs.fish
    pkgs.fzf
    pkgs.atuin
    pkgs.fd
    pkgs.bat
    pkgs.ncdu
    pkgs.duf
    pkgs.eza
    pkgs.zoxide
    pkgs.stow
    pkgs.git
    pkgs.starship
    pkgs.neovim
    pkgs.openvpn
    pkgs.cargo
    pkgs.lua51Packages.luarocks
    pkgs.nodejs
    pkgs.ripgrep

    pkgs.xfce.mousepad

    #colorscheme
    pkgs.catppuccin-gtk # Tema GTK
    pkgs.libsForQt5.qt5ct

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
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

  # gtk = {
  #   enable = true;
  #   theme.name = "catppuccin-mocha-blue-standard+default";
  #   cursorTheme.name = "Bibata-Modern-Classic";
  #   iconTheme.name = "Papirus-Dark";
  #   # font = "Cantarell 11";
  # };

  # xdg.gtk = {
  #   enable = true;
  #   themes = {
  #     gtk3 = "Catppuccin-Mocha-Standard-Mauve";
  #     gtk4 = "Catppuccin-Mocha-Standard-Mauve";
  #   };
  # };

  xdg.mimeApps.defaultApplications = {
    "text/plain" = "nvim.desktop";
    "application/pdf" = "zen-alpha.desktop";
    # "image/*" = "gthumb.desktop";
    # "video/*" = "vlc.desktop";
    # "audio/*" = "vlc.desktop";
  };

  # programs.zsh = {
  #   enable = true;
  #   enableCompletion = true;
  #   enableAutosuggestions = true;
  #   enableSyntaxHighlighting = true;
  #   enableFzfKeyBindings = true;
  #   enableFzfWidgets = true;
  #   enableFzfTabCompletion = true;
  #   enableFzfHistory = true;
  #   enableFzfSearch = true
  # };

  # programs.fish.enable = {
  #   enable = true;
  #   # userConfig = {
  #   #   # Add fish configuration here
  #   # };
  # }
  # envExtra = ''

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
