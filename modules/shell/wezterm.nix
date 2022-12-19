{pkgs, ...}

{
  programs = {
    wezterm = {
      enable = true;
      dotDir = "$HOME/.config/wezterm";
    };
  };

}
