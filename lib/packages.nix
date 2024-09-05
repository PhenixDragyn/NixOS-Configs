{ inputs, system, unfree, repo, ... }: 

{
  # Choose whether to pull from stable or unstable 
  pkgs = (import inputs.${repo} {
    inherit system; 
    config = {
      allowUnfree = unfree;
      permittedInsecurePackages = [
        #"electron-27.3.11"
      ];
    };
    hostPlatform = system;
  });

  # Some packages (ie, Vintage Story) I want to keep on unstable no matter what default repo I use
  pkgs-unstable = (import inputs.nixpkgs-unstable { 
    inherit system; 
    config = {
      allowUnfree = unfree;
      permittedInsecurePackages = [
        #"electron-27.3.11"
      ];
    };
    hostPlatform = system;
  });
}
