#
# Git
#

{
  programs = {
    git = {
      enable = true;
      userName = "shosh1n";
      userEmail = "hermannschris@googlemail.com";

      aliases = {
        ci = "commit";
        co = "checkout";
        s = "status";
      };

      extraConfig = {
        color = {
          ui = "auto";
        };
      core ={
        excludesfile = "~/.gitignore_global";
      };
    };
  };
  };
}
