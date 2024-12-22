{ pkgs, ... }:

homeManagerConfiguration = {
  programs.wezterm = {
    enable = true; # Installe WezTerm
  };
};
