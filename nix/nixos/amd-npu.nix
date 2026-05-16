{ pkgs, nix-amd-npu, ... }:
let
  inherit (pkgs) system;

  xrtSrc = pkgs.fetchFromGitHub {
    owner = "Xilinx";
    repo = "XRT";
    rev = "89b2f18e7060be7487595b8800f729589b0e83ee";
    hash = "sha256-nQuR8lZufaT4YPrCD7eFqdBTRf/K6Q3NRHlu0hYHHt0=";
    fetchSubmodules = true;
  };

  xrtFixed = nix-amd-npu.packages.${system}.xrt.overrideAttrs (_: {
    src = xrtSrc;
  });

  xrtPluginFixed =
    (nix-amd-npu.packages.${system}.xrt-plugin-amdxdna.override {
      xrt = xrtFixed;
    }).overrideAttrs
      (_: {
        inherit xrtSrc;
      });

  xrtAmdxdna = pkgs.symlinkJoin {
    name = "xrt-amdxdna-${xrtFixed.version}";
    paths = [
      xrtFixed
      xrtPluginFixed
    ];
    postBuild = ''
      for bin in $out/opt/xilinx/xrt/bin/*; do
        ln -sf $bin $out/bin/
      done
      cd $out/opt/xilinx/xrt/lib
      ln -sf "${xrtPluginFixed}/opt/xilinx/xrt/lib/libxrt_driver_xdna.so.2" .
      ln -sf "${xrtPluginFixed}/opt/xilinx/xrt/lib/libxrt_driver_xdna.so.${xrtPluginFixed.pluginVersion}" .
    '';
  };

  fastflowlm = nix-amd-npu.packages.${system}.fastflowlm.override {
    xrt = xrtFixed;
  };
  fastflowlmFixed = fastflowlm.overrideAttrs (_: {
    version = "0.9.41";
    src = pkgs.fetchFromGitHub {
      owner = "FastFlowLM";
      repo = "FastFlowLM";
      rev = "v0.9.41";
      hash = "sha256-PUbNi+rTdPvUyrfRMETBYDzVXqIzFkhYkla7ijdt/dg=";
      fetchSubmodules = true;
    };
  });
in
{
  hardware.amd-npu = {
    package = xrtAmdxdna;
  };
  environment.systemPackages = [ fastflowlmFixed xrtAmdxdna ];
}
