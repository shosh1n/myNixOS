{config, options, lib, pkgs, ...}:

with lib;
let
  name = "Christoph-Alexander Hermanns";
  maildir = "/home/shoshin/.mail";
  email = "hermannschris@gmail.com";
  #notmuchrc = "/home/shoshin/.config/notmuch/notmuchrc/";
in 
    {
    options.modules.shell.mail = {
      enable = true;
    };
  
  
  config = {
        accounts.email = {
          maildirBasePath = "${maildir}";
          accounts = {
            Gmail = {
              address = "${email}";
              userName = "${email}";
              flavor = "gmail.com";
              passwordCommand = "${pkgs.pass}/bin/pass Email/hermannschris@gmail.com";
              primary = true;
  
              mbsync = {
                enable = true;
                create = "both";
                expunge = "both";
                patterns = ["*" "Anmeldungen" "Archiv" "Belege" "Karriere"  "Orga" "Orga/Dokumente" "Orga/Sonstiges"  "Privat" "Projekte" "Reisen" "Veranstaltungen" "Privat/Filmclub" "Privat/Ideen" "Privat/Pfadis" "'[Google Mail]/Alle Nachrichten'" "'[Google Mail]/Papierkorb'" "'[Google Mail]/Wichtig'" "'[Google Mail]/Gesendet'" "'[Google Mail]/Markiert'" "'[Google Mail]/Ent&APw-rfe'" "'[Google Mail]/Spam'" "'[Google Mail]/Wichtig'"];
              };
              realName = "${name}";
              msmtp.enable = true;
            };
          };
        };
        programs = {
          msmtp.enable = true;
          mbsync.enable =  true;
        };
        
        services = {
          mbsync = {
            enable = true;
            frequency = "*:0/15";
            preExec = "${pkgs.isync}/bin/mbsync -Ha";
            postExec = "${pkgs.mu}/bin/mu index -m ${maildir}";
          };
        };
  };
}
