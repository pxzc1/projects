{ pkgs ? import <nixpkgs> {} }:

let
  # Define python with the necessary packages for Jupyter/Kernelspec
  myPython = pkgs.python310.withPackages (ps: with ps; [
    ipykernel
    jupyter-client
    # Add ML packages here so they see CUDA
  ]);
in
pkgs.mkShell {
  packages = with pkgs; [
    myPython
    stdenv.cc.cc
    glibc
    cudaPackages.cudatoolkit
  ];

  shellHook = ''
    # Fix for libstdc++.so.6 and CUDA visibility
    export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.linuxPackages.nvidia_x11}/lib:${pkgs.cudaPackages.cudatoolkit}/lib:$LD_LIBRARY_PATH
    
    # Optional: Automatically register the kernel for this shell session
    # python -m ipykernel install --user --name=nixos-cuda-env --display-name "Python 3.10 (NixOS + CUDA)"
  '';
}

#nix-shell --impure first before running to expose CUDA runtime visibility, [According to ChatGPT]