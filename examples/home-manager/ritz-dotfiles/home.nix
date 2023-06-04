{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ritz";
  home.homeDirectory = "/Users/ritz";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  programs.direnv = {
  enable = true;
  enableZshIntegration = true;
    nix-direnv = {
    enable = true;
  };
 };

  programs.neovim.enable = true;
  programs.bat.enable = true;
  programs.fzf.enable = true;
  programs.btop.enable = true;
  programs.lsd.enable = true;

  programs.zsh.enable = true;
  programs.starship = {
     enable = true;
     enableZshIntegration = true;
  };

  programs.git = {
      enable = true;
      userName = "Ritz";
      userEmail = "ritz@katzenbaum.org";
      extraConfig = {
        commit.verbose = true;
        core.editor = "hx";
      };
  };
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    pkgs.helix
    pkgs.ripgrep
    pkgs.curlie
    pkgs.ouch
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
    (pkgs.writeScriptBin "b" "home-manager switch --flake $HOME/dotfiles#ritz")
    (pkgs.writeScriptBin "e" "hx $HOME/dotfiles/home.nix")
  ];

  home.sessionVariables = {
    EDITOR = "hx";
    DIRENV_LOG_FORMAT = "";
    DIRENV_WARN_TIMEOUT = "60s";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
