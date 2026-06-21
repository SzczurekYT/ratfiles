{ config, pkgs, ... }:
{
  boot = {
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    kernelModules = [
      "v4l2loopback"
    ];
  };

  environment.systemPackages = with pkgs; [
    (prismlauncher.override {
      jdks = with pkgs; [
        temurin-jre-bin-25
      ];
    })
  ];

  hardware.sensor.iio.enable = true;
  hardware.bluetooth.enable = true;
  hardware.amd-npu.enable = true;
}
