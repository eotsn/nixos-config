{ darwin, home-manager, overlays, ... }:

{
  mkDarwinSystem = { hostname, system, username }:
    darwin.lib.darwinSystem {
      inherit system;
      specialArgs = { inherit hostname username; };
      modules = [
        ../hosts/${hostname}/configuration.nix
        {
          nixpkgs = {
            inherit overlays;
            config.allowUnfree = true;
          };
        }
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ../hosts/${hostname}/home.nix;
        }
      ];
    };
}
