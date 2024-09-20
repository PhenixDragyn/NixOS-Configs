{ ... }:

{
  services.hypridle = {
    enable = true;
		settings = {
			general = {
				after_sleep_cmd = "hyprctl dispatch dpms on";
				ignore_dbus_inhibit = false;
				lock_cmd = "hyprlock";
			};

			listener = [
				# {
				# 	timeout = 240;
				# 	on-resume = brightnessctl -r;
				# 	on-timeout = brightnessctl -s set 10;
				# }
				# {
				# 	timeout = 300;
				# 	on-resume = brightnessctl -rd rgb:kbd_backlight;
				# 	on-timeout = brightnessctl -sd rgb:kbd_backlight set 0;
				# }	
				{
					timeout = 900;
					on-timeout = "hyprlock";
				}
				{
					timeout = 1200;
					on-timeout = "hyprctl dispatch dpms off";
					on-resume = "hyprctl dispatch dpms on";
				}
			];
		};
	};
}
