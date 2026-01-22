{
  description = "Python 3.10 + CUDA runtime";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      python = pkgs.python312;
    in {
      devShells.${system}.default = pkgs.mkShell {
        name = "torch";

        packages = [
          python
          python.pkgs.pip
          pkgs.stdenv.cc.cc.lib
          pkgs.cudaPackages.cudatoolkit
        ];

        shellHook = ''
          export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.cudaPackages.cudatoolkit}/lib:$LD_LIBRARY_PATH

          venvDir="env"

          if [ ! -d "$venvDir" ]; then
            echo "Building Environment: '$venvDir'"
            python -m venv "$venvDir"
          else
            echo "Environment Already Exists."
          fi

          source "$venvDir/bin/activate"

          echo "Python: $(python --version), [env]: $venvDir"
          echo "pip: $(pip --version)"
        '';
      };
    };
}
