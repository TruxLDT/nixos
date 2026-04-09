{ self, inputs, ... }: {
  flake.nixosModules.goombaConfiguration = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.goombaHardware
      self.nixosModules.niri
    ];

    # --- System Core ---
    system.stateVersion = "25.11";
    networking.hostName = "goomba";
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;

    # --- Bootloader ---
    boot.loader.limine.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages_zen;

    # --- Networking & Security ---
    networking.networkmanager.enable = true;
    security.rtkit.enable = true;

    # --- Localization ---
    time.timeZone = "America/Chicago";
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

    # --- User Account & Shell ---
    users.users.trux = {
      isNormalUser = true;
      description = "trux";
      shell = pkgs.fish;
      extraGroups = [ "networkmanager" "wheel" "audio" "video" "input" ];
      packages = with pkgs; [];
    };

    programs.fish = {
      enable = true;
      shellAbbrs = { ll = "ls -la"; };
    };

    home-manager.users.trux = self.homeModules.truxModule;

    # --- Desktop Environment & UI ---
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    services.xserver = {
      enable = true;
      xkb = { layout = "us"; variant = ""; };
    };

    programs.niri.enable = true;
    programs.firefox.enable = true;
    services.power-profiles-daemon.enable = true;
    services.printing.enable = true;

    # --- Audio (Pipewire) ---
    services.pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
    };

    # --- Software & Fonts ---
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
  };
}
   
