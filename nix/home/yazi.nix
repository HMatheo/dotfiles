{ pkgs, ... }: {
    programs.yazi = {
    enable = true;
    package = pkgs.yazi; 
  };

  home.sessionVariables = {
    YAZI_CONFIG = "${config.home.homeDirectory}/.config/yazi/config.toml"; # Exemple pour un fichier de config perso
  };
}