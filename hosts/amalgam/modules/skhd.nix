{ pkgs, ... }:

let
  mod = "cmd + shift";

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
    ${mod} + ctrl - h : yabai -m window --swap west
    ${mod} + ctrl - j : yabai -m window --swap south
    ${mod} + ctrl - k : yabai -m window --swap north
    ${mod} + ctrl - l : yabai -m window --swap east

    # enter fullscreen mode for the focused container
    ${mod} - f : yabai -m window --toggle zoom-fullscreen

    # switch to workspace
    ${mod} - 1 : yabai -m space --focus 1
    ${mod} - 2 : yabai -m space --focus 2
    ${mod} - 3 : yabai -m space --focus 3
    ${mod} - 4 : yabai -m space --focus 4
    ${mod} - 5 : yabai -m space --focus 5

    # move focused container to workspace
    ${mod} + ctrl - 1 : yabai -m window --space 1; yabai -m space --focus 1
    ${mod} + ctrl - 2 : yabai -m window --space 2; yabai -m space --focus 2
    ${mod} + ctrl - 3 : yabai -m window --space 3; yabai -m space --focus 3
    ${mod} + ctrl - 4 : yabai -m window --space 4; yabai -m space --focus 4
    ${mod} + ctrl - 5 : yabai -m window --space 5; yabai -m space --focus 5
  '';

  system.keyboard.enableKeyMapping = true;
}
