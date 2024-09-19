{ config, ... }: 

{
  imports = [ ./waybar/scripts.nix ];

  programs.waybar = {
    enable = true;
    settings = {
        mainBar = {
				    id = "main";
				    #output = "eDP-1";
				    output = ["!eDP-1" "*"];
            layer = "top";
            position = "top";
						margin-top = 0;
						margin-bottom = 0;
						margin-right = 0;
						margin-left = 0;
						spacing = 0;

            modules-left = [
						    "custom/nixos"
								"group/tools"
            ];

            modules-center = [
						    "group/system"
            ];

            modules-right = [
								"group/switcher"
                "clock"
            ];

            # Groups
						"group/tools" = {
						    orientation = "inherit";
								modules = [
								  "custom/wlogout"
									"custom/seperator"
									"user"
									"custom/seperator"
									"idle_inhibitor"
							    "custom/nix-updates"
									"mpris"
								];
						};

						"group/system" = {
                orientation = "inherit";
								modules = [
								  "cpu"
									"memory"
									"disk"
									"custom/seperator"
									"network"
									"battery"
									"backlight"
									"pulseaudio"
									"custom/seperator"
									"tray"
								];
						};

						"group/switcher" = {
						    orientation = "inherit";
								modules = [
								  "hyprland/workspaces"
								];
						};

            # "custom/tailscale" = {
            #     format = "{icon}";
            #     exec = "$HOME/.config/waybar/scripts/tailscale.sh";
            #     exec-if = "pgrep tailscaled";
            #     return-type = "json";
            #     interval = 5;
            #     format-icons = {
            #         Running = " 󰌆 ";
            #         Stopped = " 󰌊";
            #     };
            # };

            # Modules
						"custom/seperator" = {
						    format = " | ";
							  tooltip = false;
						};

						"custom/nixos" = {
								format = ''<span color="#${config.lib.stylix.colors.base0D}">   </span>'';
							  tooltip = false;
						};

            "custom/wlogout" = {
                format = "  ";
                on-click = "wlogout";
							  tooltip = false;
            };

						tray = {
              icon-size = 16;
							spacing = 4;
							tooltip = false;
						};

            idle_inhibitor = {
                format = "{icon}";
                format-icons = {
                    activated = "  ";
                    deactivated = "  ";
                };
							  tooltip = false;
            };

            mpris = {
                format = "{player_icon} {dynamic}";
                format-paused = ''{status_icon} <i>{dynamic}</i>'';
                player-icons = { default = " ▶ "; spotify = "  "; mpv = " 🎵 "; };
                status-icons = { paused =  " ⏸ "; };
                max-length = 30;
            };

						# "custom/spotify" = {
						# 		format = "{icon} {}",
						# 		escape = true,
						# 		return-type = "json",
						# 		max-length = 40,
						# 		interval = 30, // Remove this if your script is endless and write in loop
						# 		on-click = "playerctl -p spotify play-pause",
						# 		on-click-right = "killall spotify",
						# 		smooth-scrolling-threshold = 10, // This value was tested using a trackpad, it should be lowered if using a mouse.
						# 		on-scroll-up = "playerctl -p spotify next",
						# 		on-scroll-down = "playerctl -p spotify previous",
						# 		exec = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null", // Script in resources/custom_modules folder
						# 		exec-if = "pgrep spotify"
						# }
						 
						"hyprland/workspaces" = {
								 format = "{icon}";
								 format-icons = {
								 	"1" = "   ";
								 	"2" = "   ";
								 	"3" = "   ";
								 	"4" = "   ";
								 	"5" = "   ";
								 	"6" = "   ";
								 	active = " ";
								 	default = " ";
								 };
								# format = " {name} ";

  							persistent-workspaces = {
									 "*" = 3; # 6 workspaces by default on every monitor
									 "DP-1" = 3; # but only three on external 
								};

								on-click = "activate";
							  tooltip = false;
						};
           
					  user = {
              format = "{user} ( ↑ up {work_d} days)";
							interval = 60;
							height = 30;
							width = 30;
							icon = true;
            };

							cpu = {
									interval = 10;
									format = ''<span color="#${config.lib.stylix.colors.base09}"> </span> {}%'';
									max-length = 10;
							};

							memory = {
									interval = 10;
									format = ''<span color="#${config.lib.stylix.colors.base0B}"> </span> {}%'';
									max-length = 10;
							};		

							disk = {
									interval = 10;
									format = ''<span color="#${config.lib.stylix.colors.base0E}"> </span>  /: {percentage_free}%'';
									path = "/";
							};						

							clock = {
									format = " 󰥔  {:%I:%M - %A}";
									format-alt = " 󰃭  {:%A, %d %b, %Y}";
									tooltip-format = "{tz_list}";
									timezones = [
										"America/Boise"
									];
									calendar = {
											mode = "month";
											mode-mon-col  = 3;
											weeks-pos = "left";
											on-scroll = 1;
											format = {
													months =     "<b>{}</b>";
													days =       "<b>{}</b>";
													weeks =      "<b>W{}</b>";
													weekdays =   "<b>{}</b>";
													today =      "<b><u>{}</u></b>";
											};
									};
									actions = {
											on-click-right = "kitty -e calcurse";
											on-click-middle = "mode";
											on-scroll-up = "shift_up";
											on-scroll-down = "shift_down";
									};
							};

							backlight = {
								device = "intel_backlight";
								format = "{icons} {percent}";
								format-icons = ["  " "  "];
							  tooltip = false;
							};

							pulseaudio = {
									scroll-step = 1;
									#format = "{icon}{format_source} {volume}";
									format = "{icon} {volume}";
									format-bluetooth = "{volume}% {icon} {format_source}";
									format-bluetooth-muted = " ";
									#format-muted = "  {format_source}";
									format-muted = "  ";
									format-source = "  ";
									format-source-muted = "  ";
									format-icons = {
											headphone = "  ";
											headset = "  ";
											default = ["  " "  " "  "];
									};
									tooltip = false;
									on-click = "kitty -e pulsemixer";
							};

							network = {
									format = "{ifname}";
									format-wifi = "  {ipaddr}";
									format-ethernet = "  {ipaddr}";
									format-disconnected = ""; # Hides the module
									tooltip-format = "{ifname} via {gwaddr}  ";
									tooltip-format-wifi = "{essid} ({signalStrength}%)  ";
									tooltip-format-ethernet = "{ifname} \n{ipaddr}";
									tooltip-format-disconnected = "Disconnected";
									max-length = 50;
									on-click = "kitty --class=nmtui -e nmtui";
							};

							battery = {
									tooltip = true;
									tooltip-format = "{time}";
									states = {
											warning = 35;
											critical = 20;
									};
									format = "{icon} {capacity}%";
									format-charging = " 󰂄  {capacity}%";
									format-plugged  = "   {capacity}%";
									format-icons = [ "  " "  " "  " "  " "  " ];
                  /*"format": "<span color=\"#fff\">{}</span>"*/
							};

							"custom/nix-updates" = {
									exec = "$HOME/.config/waybar/scripts/nix-updatecheck.sh"; 
									on-click = "$HOME/.config/waybar/scripts/nix-updatecheck.sh && notify-send 'The system has been updated'"; 
									interval = 3600; 
									tooltip = true;
									return-type = "json";
									format = "{} {icon}";
									format-icons = {
											"has-updates" = "  ";
											"updated" = "  ";
									};
							};
					};
			};

			style = ''
@define-color backgroundlight #${config.lib.stylix.colors.base01};
@define-color backgrounddark #${config.lib.stylix.colors.base0C};
@define-color workspacesbackground1 #${config.lib.stylix.colors.base01};
@define-color workspacesbackground2 #${config.lib.stylix.colors.base0C};
@define-color bordercolor #${config.lib.stylix.colors.base0C};
@define-color textcolor1 #FFFFFF;
@define-color textcolor2 #${config.lib.stylix.colors.base0D};
@define-color textcolor3 #${config.lib.stylix.colors.base0A};
@define-color textcolor4 #${config.lib.stylix.colors.base0B};
@define-color texturgent #${config.lib.stylix.colors.base09};
@define-color iconcolor1 #FFFFFF;
@define-color iconcolor2 #${config.lib.stylix.colors.base0D};
@define-color iconcolor3 #${config.lib.stylix.colors.base0A};
@define-color iconcolor4 #${config.lib.stylix.colors.base0B};
@define-color iconurgent #${config.lib.stylix.colors.base09};

/* -----------------------------------------------------
 * General 
 * ----------------------------------------------------- */

* {
    /*font-family: "Fira Sans Semibold", "Font Awesome 6 Free", FontAwesome, Roboto, Helvetica, Arial, sans-serif;*/
    border: none;
    border-radius: 0px;
}

window#waybar {
    background-color: rgba(0,0,0,0.5);
    border-bottom: 0px solid #ffffff;
    color: #FFFFFF; 
    background: transparent; 
    transition-property: background-color; 
    transition-duration: .5s; 
		margin: 2px;
    /* background: shade(alpa(@backgrounddark, 0.1), 1); */
}

/* -----------------------------------------------------
 * Workspaces 
 * ----------------------------------------------------- */

#workspaces {
    background: @workspacesbackground1;
    margin: 0px 0px 0px 0px;
    padding: 0px 0px;
    border-radius: 0px;
    border: 0px;
    font-weight: bold;
    font-style: normal;
    opacity: 0.8;
    font-size: 10px;
    color: @textcolor1;
}


#workspaces button {
    padding: 0px 0px;
    margin: 0px 0px;
    border-radius: 0px;
    /*border: 0px;*/
    /*color: @textcolor2;*/
    /*background-color: @workspacesbackground1;*/
		background: transparent;
    transition: all 0.3s ease-in-out;
    opacity: 0.4;
}

#workspaces button.persistent {
    color: @textcolor1; /* gray */
    background: @workspacesbackground1;
    border-radius: 0px;
    min-width: 40px;
    transition: all 0.3s ease-in-out;
    opacity:1.0;
}

#workspaces button.active {
    color: @textcolor2; /* blue */
    background: @workspacesbackground1;
    border-radius: 0px;
    min-width: 40px;
    transition: all 0.3s ease-in-out;
    opacity:1.0;
}

#workspaces button.visible {
    color: @textcolor3; /* orange */
    background: @workspacesbackground1;
    border-radius: 0px;
    min-width: 40px;
    transition: all 0.3s ease-in-out;
    opacity:1.0;
}

#workspaces button.empty {
    color: @textcolor1; /* gray */
    background: @workspacesbackground1;
    border-radius: 0px;
    min-width: 40px;
    transition: all 0.3s ease-in-out;
    opacity:1.0;
}

#workspaces button:hover {
    color: @textcolor3; /* orange */
    background: @workspacesbackground1;
    border-radius: 0px;
    opacity:0.7;
}

/* -----------------------------------------------------
 * Tooltips
 * ----------------------------------------------------- */

tooltip {
    border-radius: 0px;
    background-color: @backgroundlight;
    opacity:0.8;
    padding:20px;
    margin:0px;
}

tooltip label {
    color: @textcolor1;
}

/* -----------------------------------------------------
 * Window
 * ----------------------------------------------------- */

#window {
    background: @backgroundlight;
    margin: 2px 0px 2px 0px;
    padding: 0px 10px 0px 10px;
    border-radius: 0px;
    color:@textcolor1;
    font-size:12px;
    font-weight:normal;
    opacity:0.8;
}

window#waybar.empty #window {
    background-color:transparent;
}

/* -----------------------------------------------------
 * Taskbar
 * ----------------------------------------------------- */

#taskbar {
    background: @backgroundlight;
    margin: 2px 0px 2px 0px;
    padding:0px;
    border-radius: 0px;
    font-weight: normal;
    font-style: normal;
    opacity:0.8;
    border: 2px solid @backgroundlight;
}

#taskbar button {
    margin:0;
    border-radius: 0px;
    padding: 0px 5px 0px 5px;
}

#taskbar.empty {
    background:transparent;
    border:0;
    padding:0;
    margin:0;
}

/* -----------------------------------------------------
 * Modules
 * ----------------------------------------------------- */

.modules-left > widget:first-child > #workspaces {
    margin-left: 5;
}

.modules-right > widget:last-child > #workspaces {
    margin-right: 5;
}

/* -----------------------------------------------------
 * Custom Quicklinks
 * ----------------------------------------------------- */

#custom-brave, 
#custom-browser, 
#custom-keybindings, 
#custom-outlook, 
#custom-filemanager, 
#custom-teams, 
#custom-chatgpt, 
#custom-calculator, 
#custom-windowsvm, 
#custom-cliphist, 
#custom-settings, 
#custom-wallpaper, 
#custom-system,
#custom-hyprshade,
#custom-hypridle,
#custom-tools,
#custom-quicklink1,
#custom-quicklink2,
#custom-quicklink3,
#custom-quicklink4,
#custom-quicklink5,
#custom-quicklink6,
#custom-quicklink7,
#custom-quicklink8,
#custom-quicklink9,
#custom-quicklink10,
#custom-waybarthemes {
    margin-right: 0px;
    font-size: 14px;
    font-weight: bold;
    opacity: 0.8;
    color: @iconcolor1;
}

#custom-quicklink1,
#custom-quicklink2,
#custom-quicklink3,
#custom-quicklink4,
#custom-quicklink5,
#custom-quicklink6,
#custom-quicklink7,
#custom-quicklink8,
#custom-quicklink9,
#custom-quicklink10 {
    margin-right: 0px;   
}

#custom-tools {
    margin-right: 0px;
}

#custom-hypridle.active {
    color: @iconcolor1;
}

#custom-hypridle.notactive {
    color: #dc2f2f;
}

/* -----------------------------------------------------
 * Idle Inhibator
 * ----------------------------------------------------- */

#idle_inhibitor {
    margin-right: 5px;
    font-size: 14px;
    font-weight: bold;
    opacity: 0.8;
    color: @iconcolor1;
}

#idle_inhibitor.activated {
    margin-right: 5px;
    font-size: 14px;
    font-weight: bold;
    opacity: 0.8;
    color: #dc2f2f;
}

/* -----------------------------------------------------
 * Custom Modules
 * ----------------------------------------------------- */

#custom-nixos{
    background-color: @backgroundlight;
    font-size: 14px;
    color: @textcolor1;
    border-radius: 0px;
    padding: 0px 5px 0px 5px;
    margin: 2px 20px 2px 5px;
    opacity:0.8;
    border:2px solid @bordercolor;
}

/* -----------------------------------------------------
 * Custom Exit
 * ----------------------------------------------------- */

#custom-exit {
    margin: 2px 0px 2px 0px;
    padding:0px;
    font-size:14px;
    color: @iconcolor1;
    opacity: 0.8;
}

/* -----------------------------------------------------
 * Custom Updates
 * ----------------------------------------------------- */

#custom-updates {
    background-color: @backgroundlight;
    font-size: 14px;
    color: @textcolor1;
    border-radius: 0px;
    padding: 0px 5px 0px 5px;
    margin: 2px 0px 2px 0px;
    opacity:0.8;
}

#custom-updates.green {
    background-color: @backgroundlight;
}

#custom-updates.yellow {
    background-color: #ff9a3c;
    color: #FFFFFF;
}

#custom-updates.red {
    background-color: #dc2f2f;
    color: #FFFFFF;
}

/* -----------------------------------------------------
 * Groups
 * ----------------------------------------------------- */

#tools,#switcher,#system {
    background-color: @backgroundlight;
    font-size: 14px;
    /*color: @textcolor1;*/
    border-radius: 0px;
    padding: 0px 5px 0px 5px;
    margin: 2px 0px 2px 0px;
    opacity: 0.8;
    border:2px solid @bordercolor;
}

/* -----------------------------------------------------
 * Hardware Group
 * ----------------------------------------------------- */

#disk,#memory,#cpu,#language {
    margin: 2px 0px 2px 0px;
    padding: 0px 5px 0px 5px;
    font-size:14px;
    color:@iconcolor1;
}

#language {
    margin-right: 5px;
}

/* -----------------------------------------------------
 * Clock
 * ----------------------------------------------------- */

#clock {
    background-color: @backgroundlight;
    font-size: 14px;
    color: @textcolor1;
    border-radius: 0px;
    padding: 0px 5px 0px 5px;
    margin: 2px 5px 2px 20px;
    opacity:0.8;
    border:2px solid @bordercolor;   
}

/* -----------------------------------------------------
 * Backlight
 * ----------------------------------------------------- */

#backlight {
    background-color: @backgroundlight;
    font-size: 14px;
    color: @textcolor1;
    border-radius: 0px;
    padding: 0px 5px 0px 5px;
    margin: 2px 0px 2px 0px;
    opacity:0.8;
}

/* -----------------------------------------------------
 * Pulseaudio
 * ----------------------------------------------------- */

#pulseaudio {
    background-color: @backgroundlight;
    font-size: 14px;
    color: @textcolor1;
    border-radius: 0px;
    padding: 0px 5px 0px 5px;
    margin: 2px 0px 2px 0px;
    opacity:0.8;
}

#pulseaudio.muted {
    background-color: @backgrounddark;
    color: @texturgent;
}

/* -----------------------------------------------------
 * Network
 * ----------------------------------------------------- */

#network {
    background-color: @backgroundlight;
    font-size: 14px;
    color: @textcolor1;
    border-radius: 0px;
    padding: 0px 5px 0px 5px;
    margin: 2px 0px 2px 0px;
    opacity:0.8;
}

#network.ethernet {
    background-color: @backgroundlight;
    color: @textcolor1;
}

#network.wifi {
    background-color: @backgroundlight;
    color: @textcolor1;
}

/* -----------------------------------------------------
 * Bluetooth
 * ----------------------------------------------------- */

#bluetooth, #bluetooth.on, #bluetooth.connected {
    background-color: @backgroundlight;
    font-size: 14px;
    color: @textcolor1;
    border-radius: 0px;
    padding: 0px 5px 0px 5px;
    margin: 2px 0px 2px 0px;
    opacity:0.8;
}

#bluetooth.off {
    background-color: transparent;
    padding: 0px;
    margin: 5px;
}

/* -----------------------------------------------------
 * Battery
 * ----------------------------------------------------- */

#battery {
    background-color: @backgroundlight;
    font-size: 14px;
    color: @textcolor1;
    border-radius: 0px;
    padding: 0px 5px 0px 5px;
    margin: 2px 0px 2px 0px;
    opacity:0.8;
}

#battery.charging, #battery.plugged {
    color: @textcolor1;
    background-color: @backgroundlight;
}

@keyframes blink {
    to {
        background-color: @backgroundlight;
        color: @textcolor1;
    }
}

#battery.critical:not(.charging) {
    background-color: #f53c3c;
    color: @textcolor1;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

/* -----------------------------------------------------
 * Tray
 * ----------------------------------------------------- */

#tray {
    padding: 0px 5px 0px 5px;
}

#tray > .passive {
    -gtk-icon-effect: dim;
}

#tray > .needs-attention {
    -gtk-icon-effect: highlight;
}


    '';
  };
}

