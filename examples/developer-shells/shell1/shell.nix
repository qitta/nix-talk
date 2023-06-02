# Commit: tag 19.03 {pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/f52505fac8c82716872a616c501ad9eff188f97f.tar.gz") {}}: let
{pkgs ? import <nixpkgs> {}}: let
  message = "hello world";
in
  pkgs.mkShell {
    buildInputs = with pkgs; [figlet go];
    shellHook = ''
      figlet ${message}
      go version
    '';
  }
