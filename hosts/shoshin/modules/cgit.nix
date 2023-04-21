{ config, lib, pkgs, ... }:

{
  modules.services.cgit = {
    enable = true;
    domain = "git.cherma.org";
    reposDirectory = "/srv/git";
    extraConfig = ''
      robots=noindex, nofollow
      enable-index-owner=0
      enable-http-clone=1
      enable-commit-graph=1
      clone-prefix=https://git.cherma.org
    '';
  };

  services.nginx.virtualHosts."git.cherma.org" = {
    http2 = true;
    forceSSL = true;
    enableACME = true;
  };
}
