{config, options, lib, pkgs, ...}

with lib;
let
  name = "Christoph-Alexander Hermanns";
  maildir = "/home/shoshin/.mail";
  email = "hermannschris@googlemail.com";
  notmuchrc = "/home/shoshin/.config/notmuch/notmuchrc/"
in {
  options.modules.shell.mail = {
    enable = true;
  };
};

config = {
  my = {
    packages = with pkgs; [ mu isync ];
    home = {
      accounts.email {
        maildirBasePath = "${maildir}";
        accounts = {
          Gmail = {
            address = "${email}";
            userName = "${email}";
            flavor = "gmail.com";
            passwordCommand = "${pkgs.pass}/bin/pass Email/GmailApp";
            primary = true;

            mbsync = {
              enable = true;
              create = "both";
              expunge = "both";
              patterns = ["*" "[Gmail]*" ];
            };
            realName = "${name}";
            msmtmp.enable = true;
          };
        };
      };
      programs = {
        msmtp.enable = true;
        mbsync.enable =  true;
      }
      
      services = {
        mbsync = {
          enable = true;
          frequency = "*:0/15";
          preExec = "${pkgs.isync}/bin/mbsync -Ha";
          postExec = "${pkgs.mu}/bin/mu index -m ${maildir}";
        }
      }

    }
  }
}
