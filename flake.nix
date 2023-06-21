{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        rec {
          packages = flake-utils.lib.flattenTree rec {
            sourcery-analytics = (import ./sourcery-analytics.nix { inherit pkgs; });
            default = sourcery-analytics;
          };

          apps.sourcery-analytics.type = "app";
          apps.sourcery-analytics.program = "${packages.sourcery-analytics}/bin/sourcery-analytics";
          apps.default = apps.sourcery-analytics;
        });
}
