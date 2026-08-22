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

      checks = forAllSystems (system: {
        package = self.packages.${system}.default;
      });
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
