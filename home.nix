{ config, pkgs, inputs, ... }:

{
  home.username = "tropicbliss";
  home.homeDirectory = "/home/tropicbliss";
  home.packages = with pkgs; [
    libreoffice-qt6-fresh
    bitwarden-desktop
    discord
    obsidian
    the-powder-toy
    zoom-us
    prismlauncher
    modrinth-app
    android-studio
    inputs.zen-browser.packages."${pkgs.system}".default
    python314
    nodejs_22
  ];
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
  programs.fish = {
    enable = true;
    shellAbbrs = {
      "refresh" = "sudo nixos-rebuild switch";
      "config" = "sudo nano /etc/nixos/configuration.nix";
      "flake" = "sudo nano /etc/nixos/flake.nix";
      "home" = "sudo nano /etc/nixos/home.nix";
      "update" = "pushd /etc/nixos; and nix flake update; and popd";
      "upgrade" = "pushd /etc/nixos; and sudo nixos-rebuild switch --flake .; and popd";
      "gc" = "nix-collect-garbage -d";
    };
  };
  programs.bash = {
    enable = true;
    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };
  programs.gh.enable = true;
  programs.git = {
    enable = true;
    userName = "tropicbliss";
    userEmail = "tropicbliss@protonmail.com";
    extraConfig = {
      pull.rebase = true;
      init.defaultBranch = "main";
      core.editor = "codium --wait";
    };
  };
  programs.ripgrep.enable = true;
  programs.chromium.enable = true;
  programs.btop.enable = true;
  programs.wezterm.enable = true;
  programs.ghostty.enable = true;
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = [
      pkgs.vscode-extensions.bbenoist.nix
    ];
  };
}
