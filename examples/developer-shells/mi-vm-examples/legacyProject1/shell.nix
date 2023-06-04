{pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/master.tar.gz") {}}: let

  sbuild = pkgs.writeScriptBin "sbuild" ''
    go build -o app_static --ldflags '-linkmode external -extldflags=-static' main.go
  '';

  clean = pkgs.writeScriptBin "clean" ''
    #!/usr/bin/env bash
    if [[ -f app_static ]]; then
      rm app_static
    fi
  '';
in
  pkgs.mkShell {
    buildInputs = with pkgs; [ valgrind go musl ] ++ [ sbuild clean ];

    CGO_ENABLED = 1;
    CC = "musl-gcc";

    shellHook = ''
      echo "$(${pkgs.gum}/bin/gum style --foreground 212 "Go + C Environment") loaded."
      echo "Run $(${pkgs.gum}/bin/gum style --foreground 212 sbuild) to build a statically linked binary."
      echo "Run $(${pkgs.gum}/bin/gum style --foreground 212 clean) to clean all binaries."
      echo "Run $(${pkgs.gum}/bin/gum style --foreground 212 valgrind) ./app_static to debug."
    '';
  }
