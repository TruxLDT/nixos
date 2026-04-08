{ self, inputs, ...}: {
  flake.nixosModules.vmHardware = { config, lib, pkgs, modulesPath, ... }: {
	imports =
	    [ (modulesPath + "/profiles/qemu-guest.nix")
	    ];

	  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
	  boot.initrd.kernelModules = [ ];
	  boot.kernelModules = [ "kvm-amd" ];
	  boot.extraModulePackages = [ ];

	  fileSystems."/" =
	    { device = "/dev/disk/by-uuid/49a23abb-20c7-4795-b888-41ac64a4dbdd";
	      fsType = "ext4";
	    };

	  swapDevices = [ ];

	  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

};
}
