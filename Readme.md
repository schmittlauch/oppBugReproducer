This repo contains a [Nix](https://nixos.org/nix) environment and the [Omnet++ tictoc example](https://docs.omnetpp.org/tutorials/tictoc/) to reproduce a bug in the QtEnv of Omnet++.

## reproduce the bug

`nix-shell --pure --run "opp_makemake && make && ./oppBugReproducer"`

The command above builds the necessary Nix environment – including building omnetpp – and then compiles and runs the tictoc example in it.

## Expected bug:

```
Creating Makefile in /home/spiollinux/src/oppBugReproducer...
Creating executable: out/gcc-release//oppBugReproducer
OMNeT++ Discrete Event Simulation  (C) 1992-2019 Andras Varga, OpenSim Ltd.
Version: 5.6.2, build: 200518-aa79d0918f, edition: Academic Public License -- NOT FOR COMMERCIAL USE
See the license for distribution terms and warranty disclaimer

Setting up Qtenv...

Loading NED files from .:  1

Loading images from '/nix/store/gys5kyqqh0f97fmi1fd8bqyrd4x641l3-omnetpp-5.6.2/share/images': *: 0  abstract/*: 90  background/*: 4  block/*: 320  device/*: 195  logo/*: 1  maps/*: 9  misc/*: 70  msg/*: 55  old/*: 111  status/*: 28 

ASSERT: "length() > 0" in file /nix/store/fbps5ndffi4fwz9xjq0s8pzllpdj5x93-qtbase-5.15.2-dev/include/QtCore/qline.h, line 383
/tmp/nix-shell-18176-0/rc: line 1: 18240 Aborted                 (core dumped) ./oppBugReproducer

```
