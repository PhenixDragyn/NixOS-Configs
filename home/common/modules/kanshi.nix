{ hostname, ... }:

let
  machines = {
    nixos-lt = [{
      profile.name = "laptop";
      profile.outputs = [
        {
          criteria = "eDP-1";
					status = "enable";
					mode = "2560x1600";
          scale = 1.25;
        }
      ];
    }
      {
        profile.name = "work";
        profile.outputs = [
          {
            criteria = "eDP-1";
					  status = "enable";
						position = "450,1622";
					  mode = "2560x1600";
            scale = 1.25;
          }
          {
						#criteria = "DP-1";
						criteria = "Dell Inc. DELL U2718Q 4K8X78AS10UL";
						status = "enable";
						position = "0,0";
						mode = "3840x2160";
						scale = 1.333333;
          }
        ];
      }];
  };
in
{
  services.kanshi = {
    enable = true;
    settings = machines."${hostname}";
		systemdTarget = "hyprland-session.target";
  };
}

