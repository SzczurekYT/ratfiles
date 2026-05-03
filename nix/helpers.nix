{
  featureOnlyModule = (
    feature: moduleFn:
    {
      config,
      lib,
      pkgs,
      ...
    }@args:
    let
      hasFeature = builtins.elem feature config.currentSystem.features;
    in
    {
      config = lib.mkIf hasFeature (moduleFn args);
    }
  );
}
