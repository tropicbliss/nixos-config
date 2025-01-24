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
    papirus-icon-theme
    devbox
    airshipper
    jetbrains.idea-community-bin
  ];
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
  programs.fish = {
    enable = true;
    shellAbbrs = {
      "refresh" = "sudo nixos-rebuild switch";
      "config" = "nano /etc/nixos/configuration.nix";
      "flake" = "nano /etc/nixos/flake.nix";
      "home" = "nano /etc/nixos/home.nix";
      "update" = "pushd /etc/nixos; and nix flake update; and popd";
      "upgrade" = "pushd /etc/nixos; and sudo nixos-rebuild switch --flake .; and popd";
      "gc" = "nix-collect-garbage -d";
      "create" = "nix flake init --template github:cachix/devenv";
      "orgcreate" = "devbox init; and devbox generate direnv";
      "repl" = "temp python314 nodejs_22 zulu23";
    };
    functions = {
      "temp" = "nix-shell -p $argv";
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
    ignores = [
      ".envrc"
      ".direnv"
      ".devbox"
      "devbox.json"
      "devbox.lock"
    ];
  };
  programs.ripgrep.enable = true;
  programs.chromium.enable = true;
  programs.btop.enable = true;
  programs.wezterm.enable = true;
  programs.ghostty.enable = true;
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      mkhl.direnv
      svelte.svelte-vscode
      rust-lang.rust-analyzer
    ];
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.plasma = {
    enable = true;
    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      iconTheme = "Papirus-Dark";
      wallpaper = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/Patak/contents/images/1080x1920.png";
    };
    input.touchpads = [
      {
        enable = true;
        name = "UNIW0001:00 093A:0255 Touchpad";
        vendorId = "093a";
        productId = "0255";
        naturalScroll = true;
        scrollSpeed = 0.3;
      }
    ];
  };
}
