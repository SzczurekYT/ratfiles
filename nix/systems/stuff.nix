{ ... }:
rec {
  systemNames = [
    "kot"
    "szczurek-portable"
    "rat-laptok"
  ];
  systemPaths = builtins.listToAttrs (
    builtins.map (name: {
      inherit name;
      value = ./. + "/${name}";
    }) systemNames
  );
  systems = builtins.mapAttrs (name: value: import value) systemPaths;
  isNixSystem = name: builtins.elem name systems.${name}.currentSystem.features;
}
