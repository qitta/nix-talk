{
  description = "A basic devShell for heimdall";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachSystem ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"] (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells = {
          test = import ./shell.nix {inherit pkgs;};
        };

        packages = {
          nginx-libressl = pkgs.nginx.override {
            openssl = pkgs.libressl;
          };

          nginx-openssl = pkgs.nginx;

          curlDynamic = pkgs.curl;

          curlStatic = pkgs.pkgsStatic.curl;

          curlCrossStatic = pkgs.pkgsCross.aarch64-multiplatform.pkgsStatic.curl.override {
            wolfsslSupport = true;
            opensslSupport = false;
          };

          mpv = pkgs.mpv-unwrapped.override {
            sixelSupport = false;
          };

          default = pkgs.mpv-unwrapped.override {
            sixelSupport = true;
          };
        };
      }
    );
}
