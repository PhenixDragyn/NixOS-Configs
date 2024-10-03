{ config, username, ... }: {

    programs.wlogout = {
        enable = true;
        layout = [
            {
                label    = "lock";
                action   = "swaylock";
                text     = "Lock";
                circular = true;
                keybind = "l";
            }
            {
                label    = "hibernate";
                action   = "systemctl hibernate";
                text     = "Hibernate";
                circular = true;
                keybind  = "h";
            }
            {
                label    = "logout";
                action   = "loginctl terminate-user $USER";
                text     = "Logout";
                circular = true;
                keybind  = "e";
            }
            {
                label    = "shutdown";
                action   = "systemctl poweroff";
                text     = "Shutdown";
                circular = true;
                keybind  = "s";
            }
            {
                label    = "suspend";
                action   = "systemctl suspend";
                text     = "Suspend";
                circular = true;
                keybind  = "u";
            }
            {
                label    = "reboot";
                action   = "systemctl reboot";
                text     = "Reboot";
                circular = true;
                keybind  = "r";
            }
        ];
    };

		home.file = {
			".config/wlogout" = {
				source = ./wlogout;
				recursive = true;
			};

			".config/wlogout/icons".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/common/modules/wlogout";
		};

    xdg.configFile."wlogout/style.css" = {
        enable = true;
        target = "./wlogout/style.css";
				text = ''
@define-color color11 #${config.lib.stylix.colors.base0B};

/* -----------------------------------------------------
 * General 
 * ----------------------------------------------------- */

* {
    /*font-family: "Fira Sans Semibold", FontAwesome, Roboto, Helvetica, Arial, sans-serif;*/
	background-image: none;
	transition: 20ms;
	box-shadow: none;
}

window {
	/*background: url("../ml4w/cache/blurred_wallpaper.png");*/
	background: transparent;
	background-size: cover;
}

button {
	color: #FFFFFF;
  font-size:20px;

  background-repeat: no-repeat;
	background-position: center;
	background-size: 25%;

	border-style: solid;
	background-color: rgba(12, 12, 12, 0.7);
	border: 2px solid #FFFFFF;

  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
}

button:focus,
button:active,
button:hover {
    color: @color11;
	  background-color: rgba(12, 12, 12, 0.95);
	  border: 2px solid @color11;
}

/* 
----------------------------------------------------- 
Buttons
----------------------------------------------------- 
*/

#lock {
	margin: 10px;
	border-radius: 2px;
	background-image: image(url("/home/${username}/.config/wlogout/icons/lock.png"));
}

#logout {
	margin: 10px;
	border-radius: 2px;
	background-image: image(url("/home/${username}/.config/wlogout/icons/logout.png"));
}

#suspend {
	margin: 10px;
	border-radius: 2px;
	background-image: image(url("/home/${username}/.config/wlogout/icons/suspend.png"));
}

#hibernate {
	margin: 10px;
	border-radius: 2px;
	background-image: image(url("/home/${username}/.config/wlogout/icons/hibernate.png"));
}

#shutdown {
	margin: 10px;
	border-radius: 2px;
	background-image: image(url("/home/${username}/.config/wlogout/icons/shutdown.png"));
}

#reboot {
	margin: 10px;
	border-radius: 2px;
	background-image: image(url("/home/${username}/.config/wlogout/icons/reboot.png"));
}
				'';



        # text = ''
        #     * {
        #         background-image: none;
        #     }
        #     window {
        #         background-color: #${config.lib.stylix.colors.base00};
        #     }
        #     button {
        #         color: #${config.lib.stylix.colors.base04};
        #         font-size: 24px;
        #         border-radius: 5000px;
        #         margin: 25px;
        #         background-color: #${config.lib.stylix.colors.base02};
        #         border-style: solid;
        #         border-width: 3px;
        #         background-repeat: no-repeat;
        #         background-position: center;
        #         background-size: 25%;
        #     }
        #     button:active, button:hover {
        #         background-color: #${config.lib.stylix.colors.base08};
        #         color: #${config.lib.stylix.colors.base00};
        #         outline-style: none;
        #     }
        #
        #     #lock { background-image: url("/etc/nixos/git/home-manager/common/desktops/hyprland/assets/wlogout/lock.png"); }
        #     #logout { background-image: url("/etc/nixos/git/home-manager/common/desktops/hyprland/assets/wlogout/logout.png"); }
        #     #suspend { background-image: url("/etc/nixos/git/home-manager/common/desktops/hyprland/assets/wlogout/suspend.png"); }
        #     #hibernate { background-image: url("/etc/nixos/git/home-manager/common/desktops/hyprland/assets/wlogout/hibernate.png"); }
        #     #shutdown { background-image: url("/etc/nixos/git/home-manager/common/desktops/hyprland/assets/wlogout/shutdown.png"); }
        #     #reboot { background-image: url("/etc/nixos/git/home-manager/common/desktops/hyprland/assets/wlogout/reboot.png"); }
        # '';
    };
}
