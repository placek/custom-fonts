{
  description = "Custom fonts";

  inputs = {
    nixpkgs.url  = "github:NixOS/nixpkgs/9e86f5f7a19db6da2445f07bafa6694b556f9c6d";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs         = import nixpkgs { inherit system; };
      custom-fonts = pkgs.stdenv.mkDerivation {
        name         = "custom-fonts";
        version      = "v1.0";
        src          = ./shared;
        buildPhase   = "";
        installPhase = ''
          runHook preInstall
          fontdir="$out/share/fonts/truetype"
          mkdir -p $fontdir
          cp $src/* $fontdir
          runHook postInstall
        '';
        dontConfigure = true;
      };
    in rec {
      # defaultApp     = flake-utils.lib.mkApp { drv = defaultPackage; };
      defaultPackage = custom-fonts;
      devShell       = pkgs.mkShell { buildInputs = [ custom-fonts ]; };
    }
  );
}
