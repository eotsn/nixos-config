{ pkgs, ... }:

let
  mod = "lalt";

in {
  services.skhd.enable = true;
  services.skhd.skhdConfig = ''
    # start a terminal
    ${mod} - return : ${pkgs.kitty}/bin/kitty --single-instance -d ~

    # change focus
    ${mod} - h : yabai -m window --focus west
    ${mod} - j : yabai -m window --focus south
    ${mod} - k : yabai -m window --focus north
    ${mod} - l : yabai -m window --focus east

    # move focused window
    ${mod} + shift - h : yabai -m window --swap west
    ${mod} + shift - j : yabai -m window --swap south
    ${mod} + shift - k : yabai -m window --swap north
    ${mod} + shift - l : yabai -m window --swap east

    # enter fullscreen mode for the focused container
    ${mod} - f : yabai -m window --toggle zoom-fullscreen

    # switch to workspace
    ${mod} - 1 : yabai -m space --focus 1
    ${mod} - 2 : yabai -m space --focus 2
    ${mod} - 3 : yabai -m space --focus 3
    ${mod} - 4 : yabai -m space --focus 4
    ${mod} - 5 : yabai -m space --focus 5

    # move focused container to workspace
    ${mod} + shift - 1 : yabai -m window --space 1; yabai -m space --focus 1
    ${mod} + shift - 2 : yabai -m window --space 2; yabai -m space --focus 2
    ${mod} + shift - 3 : yabai -m window --space 3; yabai -m space --focus 3
    ${mod} + shift - 4 : yabai -m window --space 4; yabai -m space --focus 4
    ${mod} + shift - 5 : yabai -m window --space 5; yabai -m space --focus 5
  '';

  system.keyboard.enableKeyMapping = true;
}
