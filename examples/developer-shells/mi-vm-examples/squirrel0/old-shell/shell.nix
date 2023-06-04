# Commit: tag 19.03 {pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/f52505fac8c82716872a616c501ad9eff188f97f.tar.gz") {}}: let
#{pkgs ? import <nixpkgs> {}}: let
#
# Pinning of old nixpkgs required to get go version 1.11 (prototype target)
{pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/f52505fac8c82716872a616c501ad9eff188f97f.tar.gz") {}}: let
  message = "welcome to the squirrel shell (old version)";
in
  pkgs.mkShell {
    buildInputs = with pkgs; [ go ];
    shellHook = ''
    USER=$(basename $HOME)
    echo "Hello, $USER ${message}"
    '';
  }
