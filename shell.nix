{ pkgs ? import <nixpkgs> { config.allowUnfree = true; } }:

let
  myPython = pkgs.python311.withPackages (ps: with ps; [
    ipykernel
    jupyter-client
  ]);

in
pkgs.mkShell {
  name = "cuda-env";

  packages = with pkgs; [
    myPython
    stdenv.cc.cc.lib
    cudaPackages.cudatoolkit
    linuxPackages.nvidia_x11
  ];

  shellHook = ''
    export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.linuxPackages.nvidia_x11}/lib:${pkgs.cudaPackages.cudatoolkit}/lib:$LD_LIBRARY_PATH
    
    echo "PyTorch version: $(python -c 'import torch; print(torch.__version__)')"
    echo "CUDA Available:  $(python -c 'import torch; print(torch.cuda.is_available())')"
  '';
}

#nix-shell --impure first before running to expose CUDA runtime visibility, [According to ChatGPT]