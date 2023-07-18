{ lib, stdenv, requireFile, bc, ... }:

let
  name = "houdini";
  version = "19.5.640";
  license_dir = "~/.config/houdini";
in stdenv.mkDerivation rec {
  inherit name version;
  src = requireFile rec {
    name = "houdini-${version}-linux_x86_64_gcc9.3.tar.gz";
    sha256 = "192605wkfg0599k2ywq820ddd9iqn6ja919q4jwxlrha6hadmzrp";
    url = meta.homepage;
  };

  buildInputs = [ bc ];
  installPhase = ''
    patchShebangs houdini.install
    mkdir -p $out
    ./houdini.install --install-houdini \
                      --install-license \
                      --no-install-menus \
                      --no-install-bin-symlink \
                      --auto-install \
                      --no-root-check \
                      --accept-EULA 2021-10-13 \
                      $out
    echo "licensingMode = localValidator" >> $out/houdini/Licensing.opt  # does not seem to do anything any more. not sure, official docs do not say anything about it
  '';

  dontFixup = true;

  meta = with lib; {
    description = "3D animation application software";
    homepage = "https://www.sidefx.com";
    license = licenses.unfree;
    platforms = ["x86_64-linux"];
    hydraPlatforms = [ ]; # requireFile src's should be excluded
    maintainers = with maintainers; [ canndrew kwohlfahrt ];
  };
}
