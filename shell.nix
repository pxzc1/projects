{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  packages = with pkgs; [
    python310
    stdenv.cc.cc
    glibc
    cudaPackages.cudatoolkit
  ];

  shellHook = ''
    export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.linuxPackages.nvidia_x11}/lib:$LD_LIBRARY_PATH
  '';
}

#nix-shell --impure first before running to expose CUDA runtime visibility, [According to ChatGPT]