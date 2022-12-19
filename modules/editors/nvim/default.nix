#
# Neovim
#

{ pkgs, ... }:

{
  programs = {
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;

      plugins = with pkgs.vimPlugins; [

        # Syntax
        vim-nix
        vim-markdown
        #nvim-transparent
        # Quality of life
        vim-lastplace         # Opens document where you left it
        auto-pairs            # Print double quotes/brackets/etc.
        vim-gitgutter         # See uncommitted changes of file :GitGutterEnable
        # File Tree
	nerdtree              # File Manager - set in extraConfig to F6
        #transparent-nvim
        # Customization 
        wombat256-vim         # Color scheme for lightline
        catppuccin-nvim

        lightline-vim         # Info bar at bottom
	indent-blankline-nvim # Indentation lines
      ];

      extraConfig = ''
        syntax enable                             " Syntax highlighting
        colorscheme catppuccin                      " Color scheme text
        let g:lightline = {
          \ 'colorscheme': 'wombat',
          \ }                                     " Color scheme lightline
        highlight Comment cterm=italic gui=italic " Comments become italic
        hi Normal guibg=NONE ctermbg=NONE         " Remove background, better for personal theme
        
        set number                                " Set numbers
        nmap <F6> :NERDTreeToggle<CR>             " F6 opens NERDTree
      '';
    };
  };
}
