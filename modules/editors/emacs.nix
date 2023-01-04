{ config, pkgs, ... }:

{
  services.emacs = {
    enable = true;
  };

  serices.emacs = {
    package = import /home/shoshin/.emacs.d {pkgs = pkgs; };
  };
