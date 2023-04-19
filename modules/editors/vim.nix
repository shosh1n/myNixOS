{ config, options, lib, pkgs, inputs, ... }:

with lib;
with lib.my;
let cfg = config.modules.editors.vim;
in {
  options.modules.editors.vim = {
    enable = mkBoolOpt false;
  };


  config = mkIf cfg.enable {
    nixpkgs.overlays = [ inputs.neovim-nightly-overlay.overlay ];

    user.packages = with pkgs; [
      editorconfig-core-c
      neovim-nightly
      ctags
      vimPlugins.vim-nix
      vimPlugins.vim-markdown
      vimPlugins.vim-lastplace
      vimPlugins.vim-gitgutter
      unstable.lua-language-server
      lazygit
      unstable.neovim
    ];




    # This is for non-neovim, so it loads my nvim config
    # env.VIMINIT = "let \\$MYVIMRC='\\$XDG_CONFIG_HOME/nvim/init.vim' | source \\$MYVIMRC";

    environment.shellAliases = {
      vim = "nvim";
      v   = "nvim";
    };
  };
}
