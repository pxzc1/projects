{
  description = "Python 3.10.13 dev shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-22.11";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          pkgs.python310
          pkgs.python310Packages.pip
          pkgs.python310Packages.virtualenv
        ];
      };
    };
}
