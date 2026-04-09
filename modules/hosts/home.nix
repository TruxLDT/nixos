{ self, inputs, config, lib, ... }: {

  # This is your standalone home-manager configuration, meant to be used on non-nixos machines
  # with the home-manager command
  flake.homeConfigurations.trux = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
    modules = [
      self.homeModules.truxModule
      {
        home.username = "trux";
        home.homeDirectory = "/home/trux";
      }
    ];
  };

  # This is your home.nix, your module where you configure home-manager
  # It's imported both in standalone configuration above, and in your nixos configuration
  


  flake.homeModules.truxModule = { pkgs, ... }: {

      programs.fish.enable = true;

      xdg.configFile."nvim".source = ../../config/nvim;

      home.packages = with pkgs; [
      # Terminals & Shells

      kitty
      tmux
    
      # Editors & IDEs
      neovim
      lua51Packages.tree-sitter-cli
      vscode
      kdePackages.kate
    
      # Browsers
      brave
    
      # Utilities & Tools
      bat
      htop
      fastfetch
      nix-search-tv
      speedtest-cli
      unzip
      playerctl
      lazygit
      fzf
      ripgrep
      fd
      trashy
      git
    
      # Development (user-level)
      lua51Packages.lua
      luarocks
    
      # KDE Apps (user-specific)
      kdePackages.dolphin
    
      # Audio Control
      pavucontrol 
    ];
    home.stateVersion = "24.11";
  };

}
