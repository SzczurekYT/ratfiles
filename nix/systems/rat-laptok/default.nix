{ ... }:
{
  imports = [ ../. ];

  currentSystem = {
    username = "szczurek";
    hostname = "rat-laptok";

    features = [ "nixos" ];
  
    stateVersion = {
     system = "25.11";
     homeManager = "25.11";
    };
  };
}

