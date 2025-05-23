{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # utils
    fzf # A command-line fuzzy finder
    go
    gopass
    jq # A lightweight and flexible command-line JSON processor
    kubectl
    kubernetes-helm
    lazygit # TUI git client
    presenterm
    ripgrep # recursively searches directories for a regex pattern
    zellij
  ];

  programs = {
    # modern vim
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
    };

    # A modern replacement for ‘ls’
    # useful in bash/zsh prompt, not in nushell.
    eza = {
      enable = true;
      git = true;
      icons = "auto";
      enableZshIntegration = true;
    };

    # terminal file manager
    yazi = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        manager = {
          show_hidden = true;
          sort_dir_first = true;
        };
      };
    };

    # skim provides a single executable: sk.
    # Basically anywhere you would want to use grep, try sk instead.
    # skim = {
    #   enable = true;
    #   enableBashIntegration = true;
    # };
  };

}
