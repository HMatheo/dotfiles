{ pkgs, ... }: {

  ##########################################################################
  # 
  #  Install all apps and packages here.
  #
  #
  ##########################################################################

  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331
  environment.systemPackages = with pkgs; [
    neovim
    git
    just # use Justfile to simplify nix-darwin's commands 
    nushell # a modern shell written in Rust
    carapace # auto completion for nushell
    zoxide # a faster way to navigate your filesystem
    sqlite # a C-language library that implements a small, fast, self-contained, high-reliability, full-featured, SQL database engine
    mariadb # a community-developed fork of MySQL
    jc # a CLI tool and python library that converts the output of popular command-line tools and file-types to JSON or Dictionaries
    php
    nodejs
  ];
  environment.variables.EDITOR = "nvim";
 
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true; # Fetch the newest stable branch of Homebrew's git repo
      upgrade = true; # Upgrade outdated casks, formulae, and App Store apps
      # 'zap': uninstalls all formulae(and related files) not listed in the generated Brewfile
      cleanup = "zap";
    };

    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas 
    masApps = {
      Xcode = 497799835;
      MKPlayer = 1335612105;
    };

    taps = [
      "homebrew/services"
    ];

    # `brew install`
    brews = [
      "wget" # download tool
      "watchman"
      "iproute2mac"
      "yarn"
      "lazygit"
    ];

    # `brew install --cask`
    casks = [
      "firefox"
      "google-chrome"
      "visual-studio-code"

      # IM & audio & remote desktop & meeting
      "telegram"
      "discord"
      "spotify"

      "raycast" # (HotKey: alt/option + space)search, caculate and run scripts(with many plugins)
      
      "karabiner-elements"

      "rectangle"
      
      "ghostty"

    ];
  };
}
