{ config, lib, ... }:

{
  modules.services.gitea.enable = true;

  services.gitea = {
    appName = "Gitea";
    domain = "cherma.org";
    rootUrl = "https://git.cherma.org/";
    disableRegistration = true;
    dump = {
      enable = true;
      backupDir = "/backup/gitea";
    };
    settings = {
      server.SSH_DOMAIN = "cherma.org";
      mailer = {
        ENABLED = false;
        #FROM = "noreply@mail.cherma.org";
        #HOST = "smtp.mailgun.org:587";
        #USER = "postmaster@mail.cherma.org";
        #MAILER_TYPE = "smtp";
      };
    };
    mailerPasswordFile = config.age.secrets.gitea-smtp-secret.path;
  };

  services.nginx.virtualHosts."git.cherma.org" = {
    http2 = true;
    forceSSL = true;
    enableACME = true;
    root = "/srv/www/git.cherma.org";
    locations."/".proxyPass = "http://127.0.0.1:3000";
  };

  systemd.tmpfiles.rules = [
    "z ${config.services.gitea.dump.backupDir} 750 git gitea - -"
    "d ${config.services.gitea.dump.backupDir} 750 git gitea - -"
  ];
}
