{pkgs ? import <nixpkgs> {}}: let
  message = "hello world";
in
  pkgs.mkShell {
    buildInputs = with pkgs; [cowsay go];
    shellHook = ''
      cowsay ${message}
    '';
  }
