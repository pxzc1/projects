{
  description = "Python 3.12 + CUDA";

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
        name = "torch-shell";

        packages = with pkgs; [
          python
          python.pkgs.pip
          python.pkgs.virtualenv
          zlib
          stdenv.cc.cc
          glibc
          cudaPackages.cudatoolkit #cuda
        ];

        shellHook = ''
          export venvDir=env
          
          export LD_LIBRARY_PATH="/run/opengl-driver/lib:/run/opengl-driver-32/lib:${pkgs.lib.makeLibraryPath [
            pkgs.stdenv.cc.cc
            pkgs.zlib
            pkgs.cudaPackages.cudatoolkit
          ]}:$LD_LIBRARY_PATH"

          if [ ! -d "$venvDir" ]; then
            echo "Creating Virtual Environment in $venvDir"
            ${python}/bin/python -m venv "$venvDir"
          fi

          source "$venvDir/bin/activate"

          echo "Python: $(python --version)"
          echo "Pip: $(pip --version)"
          
          python src/utils/test/verification.py
        '';
      };
    };
}
