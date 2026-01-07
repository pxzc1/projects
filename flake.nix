{
  description = "Python 3.10 development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    python310 = pkgs.python310;
  in
  {
    devShells.${system}.default = pkgs.mkShell {
      packages = [
        python310
        python310.pkgs.venvShellHook
        python310.pkgs.pip
      ];

      venvDir = "env";

      postShellHook = ''
        echo "Using Python: $(python --version)"
      '';
    };
  };
}
