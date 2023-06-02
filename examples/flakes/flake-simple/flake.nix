{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: {
    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
    packages.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.hello;

    nixosConfigurations = {
      alice-nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [./alice/configuration.nix];
      };
    };

    alice-nixos = self.nixosConfigurations.alice-nixos.config.system.build.toplevel;
  };
}
