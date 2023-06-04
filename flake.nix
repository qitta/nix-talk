{
  description = "Nix talk slides";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachSystem ["x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin"] (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = let
          deps = with pkgs; [reveal-md gum nodePackages_latest.markdown-link-check imagemagick];
          utils = import ./lib {inherit pkgs self;};
        in
          pkgs.mkShell {
            buildInputs = with utils; [serve build clean mdlinkcheck menu polaroidize] ++ deps;
            shellHook = ''
              menu
            '';
          };
        formatter = pkgs.alejandra;
      }
    );
}
