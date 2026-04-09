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

	networking.hostName = "goomba"; # Define your hostname.

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
	# You can disable this if you're only using the Wayland session.
	services.xserver.enable = true;
	services.displayManager.sddm = {
		enable = true;
		# Enables experimental Wayland support
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
	# services.pulseaudio.enable = true;
	# services.pulseaudio.support32Bit = true; # If compatibility with 32-bit applications is desired.
	security.rtkit.enable = true;


	# Enable touchpad support (enabled default in most desktopManager).
	# services.xserver.libinput.enable = true;

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.trux = {
		isNormalUser = true;
		description = "trux";
		shell = pkgs.fish;
		extraGroups = [ "networkmanager" "wheel" "audio" "video" "input"];
		packages = with pkgs; [

		];
	};
	
	programs.fish = {
		enable = true;
		shellAbbrs = {
			ll = "ls -la";
			nrs = "nixos-rebuild switch --flake ~/myNixOS#.myMachine";
		};
	};

	programs.niri.enable = true;

	# Install firefox.
	programs.firefox.enable = true;

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	services.power-profiles-daemon.enable = true;
  # services.bluetooth.enable = true;
  
	# Enable experimental settings
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	# List packages installed in system profile. To search, run:
	# $ nix search wget

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
	system.stateVersion = "25.11"; # Did you read the comment?
	};
}
