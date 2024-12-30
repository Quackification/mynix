{ config, pkgs, ... }:

{
  imports = [
    ./home-modules
  ];
  home.username = "albert";
  home.homeDirectory = "/home/albert";
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
