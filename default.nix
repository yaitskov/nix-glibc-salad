{ system ? builtins.currentSystem or "x86_64-linux" }:

let
  nix = import ./nix;
  pkgs = nix.pkgSetForSystem system {};

  myPython = pkgs.python311;

  shell = pkgs.mkShell {
    packages = [ myPython ];

    shellHook = ''
      LD_PRELOAD=${myPython.out}/lib/libpython3.so ${pkgs.bash}/bin/bash -c 'echo hello world'
      LD_PRELOAD=${myPython.out}/lib/libpython3.so bash -c 'echo hello world'
    '';
  };
in {
  inherit shell;
}
