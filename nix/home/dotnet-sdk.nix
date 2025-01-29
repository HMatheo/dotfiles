{ pkgs, ... }: {
  home.packages = [
    (with pkgs.dotnetCorePackages; combinePackages [
      sdk_6_0
      sdk_8_0
      sdk_9_0
    ])
  ];

  home.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnetCorePackages.sdk_9_0}";
  };

}
