{ config, pkgs, username, hostname, ... }:

{
  imports = [
    ./hardware.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Enable virtualisation
  virtualisation.vmware.guest.enable = true;
  services.xserver.videoDrivers = [ "vmware" ];

  # Networking
  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  # Enable Xorg, to auto-login to i3wm, with C-M-Bksp enabled
  services.xserver = {
    enable = true;
    enableCtrlAltBackspace = true;
    windowManager.i3.enable = true;
    displayManager.defaultSession = "none+i3";
    displayManager.autoLogin.enable = true;
    displayManager.autoLogin.user = username;
  };

  # Configure keymap in X11
  services.xserver.layout = "se";
  services.xserver.xkbVariant = "";
  services.xserver.xkbOptions = "ctrl:nocaps";

  ##############################################################################
  ## General settings
  ##############################################################################

  nix.settings.trusted-users = [ "root" "@wheel" ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.warn-dirty = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  ##############################################################################
  ## User accounts
  ##############################################################################

  # Create /etc/zshrc to load the nixos environment
  programs.zsh.enable = true;

  users.users."${username}" = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  ##############################################################################
  ## Locale settings
  ##############################################################################

  # Timezone
  time.timeZone = "Europe/Stockholm";

  # Locale
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  # Console keymap
  console.keyMap = "sv-latin1";

  ##############################################################################
  ## Services
  ##############################################################################

  services.openssh.enable = true;

  # Start ssh-agent as a systemd user service
  programs.ssh.startAgent = true;

  ##############################################################################
  ## Package management
  ##############################################################################

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    jetbrains-mono
  ];

  environment.systemPackages = with pkgs; [
    firefox
    vim
    wget
  ];
}
