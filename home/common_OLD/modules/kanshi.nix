{ hostname, ... }:

let
  machines = {
    nixos-lt = [
			{
				profile.name = "laptop";
				profile.outputs = [
					{
						criteria = "eDP-1";
						status = "enable";
						position = "0,0";
						mode = "2560x1600";
						scale = 1.25;
					}
				];
			}

			{
				profile.name = "home";
				profile.outputs = [
					{
						criteria = "eDP-1";
						status = "enable";
						position = "3440,0";
						mode = "2560x1600";
						scale = 1.25;
					}
					{
						#criteria = "DP-1";
						criteria = "ViewSonic Corporation VG3456 WFN214700166";
						status = "enable";
						position = "0,0";
						mode = "3440x1440";
						scale = 1.0;
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
			}
		];
  };
in
{
  services.kanshi = {
    enable = true;
    settings = machines."${hostname}";
		systemdTarget = "hyprland-session.target";
  };
}

