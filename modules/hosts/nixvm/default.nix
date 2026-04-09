{ self, inputs, ... }: {
  flake.nixosConfigurations.nixvm = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.nixvmConfiguration
      self.nixosModules.myHomeManager
    ];
  };
}
