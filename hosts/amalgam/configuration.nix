{ config, pkgs, hostname, username, ... }:

{
  imports = [
    ./modules/yabai.nix
    ./modules/skhd.nix
  ];

  nixpkgs.overlays = [
    (import ./overlays/emacs.nix)
  ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [ pkgs.vim
    ];

  environment.shells = [ pkgs.zsh ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  networking.hostName = hostname;

  users.users."${username}" = {
    home = "/Users/${username}";
  };

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    jetbrains-mono
  ];

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  programs.gnupg.agent.enable = true;

  services.lorri.enable = true;

  system.defaults.dock.autohide = true;
  system.defaults.dock.show-recents = false;

  nix.settings.trusted-users = [ "@admin" "${username}" ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.warn-dirty = false;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
