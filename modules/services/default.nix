#
#  Services
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ home.nix
#   └─ ./modules
#       └─ ./services
#           └─ default.nix *
#               └─ ...
#

[
  ./dunst.nix
  ./flameshot.nix
  ./picom.nix 
  ./udiskie.nix
  ./polybar.nix
  ./gpg-agent.nix
  ./emacs.nix
  #./dropbox.nix #using maestral
  #./python.nix
]

# Media is pulled from desktop default config
