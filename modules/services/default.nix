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
  ./polybar
]

# Media is pulled from desktop default config
