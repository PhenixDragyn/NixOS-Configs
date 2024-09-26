{ ... }:

{
  services.kanshi = {
	  enable = true;
		systemdTarget = "hyprland-session.target";
		settings = {
      profile.name = "laptop";
			profile.outputs = [
        {
          criteria = "eDP-1";
				  status = "enable";
					mode = "2560x1600";
					scale = "1.25";
				}
			];

      profile.name = "work";
			profile.outputs = [
			  {
          criteria = "eDP-1";
					status = "enable";
					positon = "450,1622";
					mode = "2560x1600";
					scale = "1.25";
				}

			  {
          criteria = "DP-1";
					status = "enable";
					position = "0,0";
					mode = "3840x2160";
					scale = "1.33";
				}
			];
		};
	};
}
