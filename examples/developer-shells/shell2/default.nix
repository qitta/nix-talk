{pkgs ? import <nixpkgs> {}}: let
  myScript = pkgs.writeScriptBin "doit" ''
    fortune | cowsay
  '';
in
  pkgs.mkShell {
    buildInputs = with pkgs; [cowsay fortune myScript];

    shellHook = ''
      echo "You entered the magic python shell"
    '';
  }
