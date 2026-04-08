{ self, inputs, ... }: {
  flake.nixosConfigurations.goomba = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.goombaConfiguration
    ];
  };
}
