{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachSystem ["x86_64-linux" "aarch64-linux"] (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        formatter = pkgs.alejandra;

        devShells.default = self.devShells.${system}.dynamic;

        devShells.dynamic = let
          build = pkgs.writeScriptBin "build" ''
            CC=gcc go build -o app main.go
          '';
        in
          pkgs.mkShell {
            name = "dynamic binary shell";
            buildInputs = [pkgs.go_1_18 pkgs.gcc build];
            CGO_ENABLED = 1;
            shellHook = ''
              echo "Use build to compile your app."
            '';
          };

        devShells.static = let
          build = pkgs.writeScriptBin "build" ''
            CC=musl-gcc go build -o app_static --ldflags '-linkmode external -extldflags=-static' main.go
          '';
        in
          pkgs.mkShell {
            name = "static binary shell";
            buildInputs = [pkgs.go_1_18 pkgs.musl build];
            CGO_ENABLED = 1;
            shellHook = ''
              echo "Use build to compile your app."
            '';
          };
      }
    );
}
