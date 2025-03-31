{
  description = "tiecia's neovim configuration";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.systems.url = "github:nix-systems/default";
  inputs.flake-utils = {
    url = "github:numtide/flake-utils";
    inputs.systems.follows = "systems";
  };

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

      in
      {
        homeManagerModules.default = {
          config = {
            home.packages = [
              # Dependencies as defined in kickstart.nvim
              pkgs.git
              pkgs.gnumake
              pkgs.unzip
              pkgs.gcc
              pkgs.ripgrep
              pkgs.xclip
              pkgs.binutils

              neovim
            ];

            programs.bash = {
              enable = true;
              shellAliases = {
                vi = "${neovim}/bin/nvim";
                v = "${neovim}/bin/nvim";
              };
              sessionVariables = {EDITOR = "${neovim}/bin/nvim";};
            };
          }
        };

        packages = rec {
          neovim = pkgs.stdenv.mkDerivation {
            name = "tiecia-neovim";
            src = ./.;
            buildPhase = ''
              cp -r $src $out
            '';
          };

          default = neovim;
        };

        devShells.default = pkgs.mkShell { packages = [ pkgs.bashInteractive ]; };
      }
    );
}
