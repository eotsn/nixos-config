{
  services.yabai.enable = true;
  services.yabai.enableScriptingAddition = true;
  services.yabai.config = {
    layout = "bsp";
    window_gap = "10";
  };
  services.yabai.extraConfig = ''
    yabai -m rule --add app='Finder' manage=off border=off layer=above
  '';
}
