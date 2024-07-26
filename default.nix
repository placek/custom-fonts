{
  pkgs ? import <nixpkgs> {},
}:
pkgs.stdenv.mkDerivation {
  name         = "custom-fonts";
  version      = "v1.3";
  src          = ./src;
  buildPhase   = "";
  installPhase = ''
    runHook preInstall
    fontdir="$out/share/fonts"
    mkdir -p $fontdir
    cp $src/* $fontdir
    runHook postInstall
  '';
  dontConfigure = true;
}
