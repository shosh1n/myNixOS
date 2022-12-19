{pkgs,lib, ...}:

{


  programs = {
    zsh = {
      enable = true;
      dotDir = ".config/zsh_nix";
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      history.size = 10000;

      initExtraBeforeCompInit = ''
      GITSTATUS_LOG_LEVEL=DEBUG
      P10K_INSTANT_PROMPT="$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
      [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
      POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
      source $HOME/.config/zsh_nix/.p10k.zsh 
        '';

      initExtra = ''
      alias dcv="LD_PRELOAD=/nix/store/cgi0lk4k1anwf5gk5yw2v4ndzaffbf2y-glib-2.72.3/lib/libglib-2.0.so dcvviewer"
      source $HOME/.zshrc
        '';
   #   zplug = {
   #     enable = true;
   #     plugins = [
   #       { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ];  }
   #     ];
   #   };
      plugins = with pkgs; [
      {
        file = "powerlevel10k.zsh-theme";
        name = "powerlevel10k";
        src = "${zsh-powerlevel10k}/share/zsh-powerlevel10k";
      }
    ];
    };
  };
}
