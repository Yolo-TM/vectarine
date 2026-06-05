{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    pkg-config
    cmake
    rustup
  ];

  buildInputs = with pkgs; [
    wayland
    libxkbcommon
    SDL2
    # rfd file dialog backends
    gtk3
    # x11 fallback
    xorg.libX11
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi
  ];

  # Force sdl2-sys to use the system SDL2 instead of building from source
  SDL2_NO_VENDOR = "1";

  # Required so pkg-config can find wayland, SDL2, etc.
  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (with pkgs; [
    wayland
    libxkbcommon
    SDL2
    gtk3
    xorg.libX11
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi
  ]);
}
