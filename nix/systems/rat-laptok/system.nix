{ config, ... }:
{
  boot = {
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    kernelModules = [
      "v4l2loopback"
    ];
  };

  hardware.sensor.iio.enable = true;
  hardware.bluetooth.enable = true;
  hardware.amd-npu.enable = true;
}
