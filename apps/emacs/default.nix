{ pkgs, config, ... }:

let
  appConfig = "${config.xdg.configHome}/nixos/apps/emacs";

in {
  programs.emacs.enable = true;
  programs.emacs.package = pkgs.emacsWithPackagesFromUsePackage {
    config = ./init.el;
    package = pkgs.emacsGit;
    alwaysEnsure = true;
  };

  home.file = with config.lib.file; {
    ".emacs.d/init.el".source = mkOutOfStoreSymlink "${appConfig}/init.el";
    ".emacs.d/settings.el".source = mkOutOfStoreSymlink "${appConfig}/settings.el";
  };
}
