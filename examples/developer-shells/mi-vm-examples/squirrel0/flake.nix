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
    flake-utils.lib.eachSystem ["x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin"] (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};

        build = pkgs.writeScriptBin "build" ''
          go build .
        '';

        clean = pkgs.writeScriptBin "clean" ''
          if [ -f ./se ]; then
          	rm -v ./se
          fi
        '';
      in {
        formatter = pkgs.alejandra;

        devShells.default = pkgs.mkShell {
          buildInputs = [pkgs.go_1_18 build clean];
	  shellHook = ''
	  echo - Squirrel emulator developer environment loaded.
	  echo "  build: build squirrel emulator"
	  echo "  clean: clean squirrel emulator"
	  echo ""
	  '';
        };
      }
    );
}
