{ config, ... }:
{
  boot = {
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    kernelModules = [
      "v4l2loopback"
    ];
    kernelPatches = [
      {
        name = "audio-fix";
        patch = ./audio_fix.patch;
      }
    ];
  };

  hardware.sensor.iio.enable = true;
  hardware.bluetooth.enable = true;
}
