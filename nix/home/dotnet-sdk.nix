{ pkgs, ... }: {
  home.packages = [
    pkgs.dotnet-sdk_6
    pkgs.dotnet-sdk_7
    pkgs.dotnet-sdk_8
  ];

  # Configurer l'environnement pour utiliser une version par défaut
  home.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnet-sdk_7}";  # Utiliser .NET 7 par défaut
  };

  # Intégration avec Nushell (optionnel)
  programs.nushell = {
    enable = true;
    extraConfig = ''
      # Ajouter .NET au PATH dans Nushell
      $env.PATH = ($env.PATH | append "${pkgs.dotnet-sdk_7}/bin")
    '';
  };
}