{ self, inputs, ... }: {
  flake.nixosModules.goombaConfiguration = { pkgs, lib, ... }: {
    # import any other modules from here
    imports = [
      self.nixosModules.myMachineHardware
      self.nixosModules.niri
    ];
    
    # Bootloader.
    boot.loader.limine.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Use latest kernel.
    boot.kernelPackages = pkgs.linuxPackages_zen;
    networking.hostName = "goomba"; 

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "America/Chicago";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

    # Enable the X11 windowing system.
    services.xserver.enable = true;
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with pipewire.
    services.pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
    };

    security.rtkit.enable = true;

    # Define a user account.
    users.users.trux = {
      isNormalUser = true;
      description = "trux";
      shell = pkgs.fish;
      extraGroups = [ "networkmanager" "wheel" "audio" "video" "input"];
      packages = with pkgs; [];
    };
    
    programs.fish = {
      enable = true;
      shellAbbrs = {
        ll = "ls -la";
      };
    };

    home-manager.users.trux = self.homeModules.truxModule;
    programs.niri.enable = true;
    programs.firefox.enable = true;
    nixpkgs.config.allowUnfree = true;
    services.power-profiles-daemon.enable = true;
  
    # Enable experimental settings
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    environment.systemPackages = with pkgs; [
      home-manager
      lm_sensors
      gcc
      wineWow64Packages.unstable
      xwayland
    ];

    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
      font-awesome_4
    ];

    # This value determines the NixOS release from which the default
    system.stateVersion = "25.11"; 
  }; 
}   
