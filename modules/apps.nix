{ pkgs, ... }:
{

  ##########################################################################
  #
  #  Install all apps and packages here.
  #
  ##########################################################################

  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331
  environment.systemPackages = with pkgs; [
    nixd # Nix LSP
    nixfmt-rfc-style # Nix formatter
    tree-sitter
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
      # TODO Feel free to add your favorite apps here.
      # QQMusic = 595615424;
    };

    # taps = [
    #   "homebrew/services"
    # ];

    # `brew install`
    # TODO Feel free to add your favorite apps here.
    brews = [
      # "curl" # no not install curl via nixpkgs, it's not working well on macOS!
    ];

    # `brew install --cask`
    casks = [
      "anytype"
      "nikitabobko/tap/aerospace"
      "akiflow"
      "claude"
      "ghostty"
      "ibkr"
    ];
  };
}
