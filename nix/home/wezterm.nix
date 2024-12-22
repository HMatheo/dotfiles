{ pkgs, ... }:

homeManagerConfiguration = {
  # Installation de wezterm
  programs.wezterm = {
    enable = true; # Active wezterm via Home Manager
  };

  # Génération du fichier de configuration wezterm.lua
  home.file.".config/wezterm/wezterm.lua".text = ''
    local wezterm = require 'wezterm'

    return {
      font = wezterm.font("FiraCode Nerd Font"), -- Police
      color_scheme = "Dracula",                 -- Thème de couleurs
      enable_tab_bar = false,                   -- Désactive la barre d'onglets
    }
  '';
};
