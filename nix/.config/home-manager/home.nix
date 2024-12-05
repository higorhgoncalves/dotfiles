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
    pkgs.kitty
    pkgs.fish
    pkgs.fzf
    pkgs.atuin
    pkgs.fd
    pkgs.ripgrep
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

    pkgs.xfce.mousepad

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
  };

#  home.activation = {
#    afterSwitch = ''
#      stow -d ~/dotfiles -t ~ config_name
#    '';
#  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # programs.fish.enable = true;
}
