{
  description = "rob's nix-darwin + home-manager config";

  inputs = {
    # x86_64-darwin was dropped from nixpkgs-unstable (26.11 dev cycle);
    # 26.05-darwin is the maintained branch for Intel Macs.
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # Not in nixpkgs. Used as a pinned source only; see nixpkgs/openspec.nix
    # for why we build it ourselves instead of using upstream's package.
    openspec.url = "github:Fission-AI/OpenSpec";
    openspec.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, openspec, ... }: {
    darwinConfigurations."lily" = nix-darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      specialArgs = { inherit openspec; };
      modules = [
        ./nixpkgs/darwin-configuration.nix
        home-manager.darwinModules.home-manager
      ];
    };
  };
}
