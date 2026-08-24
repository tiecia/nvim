{
  description = "tiecia's Neovim configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    {
      self,
      nixpkgs,
      systems,
      ...
    }:
    let
      # Nixpkgs unstable no longer evaluates on Intel macOS.
      supportedSystems = builtins.filter (system: system != "x86_64-darwin") (import systems);
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      runtimeTools =
        pkgs:
        with pkgs;
        [
          fd
          gcc
          git
          gnumake
          ripgrep
          tree-sitter
          unzip
        ]
        ++ lib.optionals stdenv.hostPlatform.isLinux [ xclip ];
    in
    {
      homeModules.default =
        { pkgs, ... }:
        {
          home.packages = runtimeTools pkgs;

          programs.neovim = {
            enable = true;
            defaultEditor = true;
          };

          programs.bash.shellAliases = {
            vi = "nvim";
            v = "nvim";
          };
          programs.zsh.shellAliases = {
            vi = "nvim";
            v = "nvim";
          };

          xdg.configFile."nvim".source = self;
        };

      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.stdenvNoCC.mkDerivation {
            pname = "tiecia-neovim";
            version = "0-unstable";
            src = self;
            nativeBuildInputs = [ pkgs.makeWrapper ];
            dontBuild = true;

            installPhase = ''
              runHook preInstall
              mkdir -p "$out/share/nvim-config/nvim-tiecia" "$out/bin"
              cp -R . "$out/share/nvim-config/nvim-tiecia"
              makeWrapper ${pkgs.neovim}/bin/nvim "$out/bin/nvim" \
                --set XDG_CONFIG_HOME "$out/share/nvim-config" \
                --set NVIM_APPNAME nvim-tiecia \
                --prefix PATH : ${pkgs.lib.makeBinPath (runtimeTools pkgs)}
              runHook postInstall
            '';

            meta.mainProgram = "nvim";
          };
        }
      );

      checks = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          package = self.packages.${system}.default;

          formatting = pkgs.runCommand "neovim-config-formatting" { nativeBuildInputs = [ pkgs.stylua ]; } ''
            stylua --check ${self}
            touch "$out"
          '';

          lua-diagnostics =
            pkgs.runCommand "neovim-config-lua-diagnostics"
              { nativeBuildInputs = [ pkgs.lua-language-server ]; }
              ''
                mkdir -p diagnostics/log diagnostics/meta "$out"
                lua-language-server \
                  --check=${self} \
                  --checklevel=Warning \
                  --check_format=pretty \
                  --configpath=${self}/.luarc.json \
                  --logpath=diagnostics/log \
                  --metapath=diagnostics/meta
              '';
        }
      );
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);

      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            packages = runtimeTools pkgs ++ [
              pkgs.lua-language-server
              pkgs.neovim
              pkgs.stylua
            ];
          };
        }
      );
    };
}
