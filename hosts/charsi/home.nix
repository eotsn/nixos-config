{ config, pkgs, lib, ... }:

{
  imports = [
    ../../apps/emacs
  ];

  home.packages = [ ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git.enable = true;
  programs.git.ignores = [
    "*~"
    "#*#"
    ".emacs.desktop"
    ".emacs.desktop.lock"
    "*.elc"
    "auto-save-list"
    "tramp"
    ".#*"
  ];
  programs.git.extraConfig = {
    url = {
      "git@github.com:" = {
        insteadOf = [ "git://github.com/" "https://github.com/" ];
      };
    };
  };
  programs.git.delta.enable = true;

  programs.kitty.enable = true;
  programs.kitty.font = {
    name = "JetBrains Mono";
    size = 12;
  };
  programs.kitty.theme = "Modus Vivendi";
  programs.kitty.settings = {
    window_padding_width = 10;
    linux_display_server = "x11";
  };

  programs.zsh.enable = true;
  programs.zsh.enableAutosuggestions = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.enableSyntaxHighlighting = true;
  programs.starship.enable = true;

  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;

  programs.exa.enable = true;
  programs.exa.enableAliases = true;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      defaultWorkspace = "workspace number 1";
      terminal = "${pkgs.kitty}/bin/kitty";
      window.titlebar = false;
      keybindings =
        let
          modifier = config.xsession.windowManager.i3.config.modifier;
        in lib.mkOptionDefault {
          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";
        };
    };
  };
}
