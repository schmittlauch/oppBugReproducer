{ 
  pkgs ? import (
    builtins.fetchGit {
      name = "nixpkgs-pinned";
      url = https://github.com/NixOS/nixpkgs/;
      ref = "refs/heads/release-20.09";
      rev = "b39544be6c2e554fc494140d1d8d1b412b2762a5";
    }) {
           # Pass no config for purity
           config = {};
         } }:

let
  omnetpp =     ((import ./omnetpp-nix/pkgs.nix { inherit pkgs; }).omnetpp.override { withIDE = true; withNEDDocGen = false; withRelease = true; withDebug = true;});
  OMNET_PATH = toString omnetpp;
  # set environment variable required for omnet to locate its image resources
  OMNETPP_IMAGE_PATH = "${OMNET_PATH}/share/images";
in

pkgs.mkShell {
  buildInputs = with pkgs; [
    omnetpp
    jre  # for gradle
    python        # for test generation
    gcc

    # optional dev tools
    doxygen
    graphviz

  ];


  # environment variables
  inherit OMNET_PATH OMNETPP_IMAGE_PATH;
  shellHook = ''
    # gradle parses the output of gcc to determine its version, this fails with non-Engllish locales 🤯 /0\
    export LANGUAGE=en
    '';
}
