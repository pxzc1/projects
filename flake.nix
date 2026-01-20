{
  description = "ML Development Environment with Python 3.10 and CUDA";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      python310 = pkgs.python310;
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        name = "cuda";

        packages = [
          python310
          python310.pkgs.venvShellHook
          python310.pkgs.pip
          pkgs.stdenv.cc.cc.lib
          pkgs.cudaPackages.cudatoolkit
          pkgs.linuxPackages.nvidia_x11
        ];

        venvDir = "env";

        shellHook = ''
          # 1. Setup CUDA/NVIDIA library paths (from your shell.nix)
          export LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.linuxPackages.nvidia_x11}/lib:${pkgs.cudaPackages.cudatoolkit}/lib:$LD_LIBRARY_PATH"
          
          # 2. Run the venvShellHook (this activates the venv automatically)
          # No need to manually 'source 3.10.15/bin/activate'
          
          echo "Environment Ready!"
          echo "Python version: $(python --version)"
          # Try to check torch if it was already installed via pip
          python -c "import torch; print(f'Torch: {torch.__version__} | CUDA: {torch.cuda.is_available()}')" 2>/dev/null || echo "Torch not yet installed in venv."
        '';
      };
    };
}