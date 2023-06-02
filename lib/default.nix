{
  self,
  pkgs,
  ...
}: let
  reveal-cmd = ''
    ${pkgs.reveal-md}/bin/reveal-md slides.md \
    --preprocessor=./css/preprocess.js \
    --css ./css/custom.css \
    --highlight-theme tokyo-night-dark \
  '';
  nix-talk-slides = "/tmp/nix-talk-slides";
  gitrev = builtins.substring 0 8 self.rev or "dirty";
in {
  serve = pkgs.writeScriptBin "serve" ''
    ${reveal-cmd} -w
  '';

  clean = pkgs.writeScriptBin "clean" ''
    if [[ -d ${nix-talk-slides} ]]; then
        chmod 777 -R ${nix-talk-slides}
        rm -rf ${nix-talk-slides}
    fi
    rm -fr ${nix-talk-slides}
  '';

  build = pkgs.writeScriptBin "build" ''
    clean
    ${reveal-cmd} --static ${nix-talk-slides}
  '';

  mdlinkcheck = pkgs.writeScriptBin "mdlinkcheck" ''
    markdown-link-check slides.md
  '';

  polaroidize = pkgs.writeScriptBin "polaroidize" ''
    #/usr/bin/env bash
    PATH=$(${pkgs.gum}/bin/gum file .)
    OUT=$(${pkgs.gum}/bin/gum input --placeholder="polaroid.png")
    THUMBNAIL="600x600"
    ${pkgs.imagemagick}/bin/convert \
    "$PATH" -thumbnail $THUMBNAIL -bordercolor white -border 10 \
    -bordercolor grey60 -border 1 -bordercolor none \
    -background none -rotate -4 \
    \
    \( "$PATH" -thumbnail $THUMBNAIL -bordercolor white -border 10 \
    -bordercolor grey60 -border 1 -bordercolor none \
    -background none -rotate 6 \
    \) \
    \
    \( "$PATH" -thumbnail $THUMBNAIL -bordercolor white -border 10 \
    -bordercolor grey60 -border 1 -bordercolor none \
    -background none -rotate -2 \
    \) \
    \
    \( "$PATH" -thumbnail $THUMBNAIL -bordercolor white -border 10 \
    -bordercolor grey60 -border 1 -bordercolor none \
    -background none -rotate -4 \
    \) \
    \
    \( "$PATH" -thumbnail $THUMBNAIL -bordercolor white -border 10 \
    -bordercolor grey60 -border 1 -bordercolor none \
    -background none -rotate -4 \
    \) \
    \
    -border 100x80 -gravity center +repage -flatten -trim +repage \
    -background black \( +clone -shadow 60x4+4+4 \) +swap -background none \
    -flatten "$OUT"
    echo "$OUT" created.
  '';

  menu = pkgs.writeScriptBin "menu" ''
    gum style --foreground 120 --border-foreground 212 --border double  --align center --width 55 --margin "1 2" --padding "1 2"  'Reproducible Developer Environments using Nix 😺 (shell rev: ${gitrev})'
    echo "  Type $(gum style --foreground 120 menu) to display this menu."
    echo "  $(gum style --foreground 120 ✎) Run $(gum style --foreground 212 serve) to serve the presentation on localhost"
    echo "  $(gum style --foreground 120 ✎) Run $(gum style --foreground 212 build ) to statically build the presentation"
    echo "  $(gum style --foreground 120 ✎) Run $(gum style --foreground 212 mdlinkcheck ) to check markdown for valid links"
    echo "  $(gum style --foreground 120 ✎) Run $(gum style --foreground 212 polaroidize) to frame a image with a polaroid frame."
  '';
}
