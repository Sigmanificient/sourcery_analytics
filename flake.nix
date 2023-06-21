{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils } @inputs:
    utils.lib.eachDefaultSystem (system:
      with import nixpkgs { inherit system; }; {
    devShells.default = mkShell {
      packages = [
        (import ./sourcery-analytics.nix { inherit pkgs; })
      ];
    };
  });
}
