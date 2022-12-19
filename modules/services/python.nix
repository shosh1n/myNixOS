#
# Python environment
# 

{pkgs, ...}:
{
buildInputs = with python34Packages;[
  python34
  numpy
  toolz
];
}
