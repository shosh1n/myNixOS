{pkgs, ...}:

{
  programs = {
    zsh = {
      enable = true;
      dotDir = "$HOME/.config/zsh_nix";
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      history.size = 10000;
    };
  };
}
