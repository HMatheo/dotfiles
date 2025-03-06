{ pkgs, ... }: {
  home.packages = [
    (with pkgs.dotnetCorePackages; combinePackages [
      sdk_8_0
    ])
  ];

  home.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnetCorePackages.sdk_8_0}";
  };

}
