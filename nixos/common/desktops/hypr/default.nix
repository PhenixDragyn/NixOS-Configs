{ lib, pkgs, pkgs-unstable, username, system, ... }:

{ 
# You can import other NixOS modules here 
  imports = [
    # Import my host modules
    #../../modules/x11.nix
  ];

  # ---------------------------------

  # NETWORKING
  # Enable network manager applet
  programs.nm-applet.enable = true;

  # ---------------------------------
# BLUETOOTH
  services.blueman.enable = true;

  # ---------------------------------

  # X2GO SERVER AND XRDP
  #services.x2goserver.enable = true;
  #services.xrdp.enable = true;
  #services.xrdp.defaultWindowManager = "startxfce4";
  #services.xrdp.openFirewall = true;

  # ---------------------------------

  # INPUT SETTINGS
  services.libinput = {
    enable = true;
  #  touchpad = {
  #    naturalScrolling = true; #nc default = false
  #    disableWhileTyping = false; # default = false
  #  };
  #  mouse = {
  #    naturalScrolling = true;
  #  };
  };

  # ---------------------------------

  # SETUP ENVIRONMENT VARIABLES
  # Environment Variables
  # environment.sessionVariables = {
  #   QT_QPA_PLATFORMTHEME = "qt5ct";
  #   #ADW_DISABLE_PORTAL = 1;
  #
  #   # Mozilla Touchscreen scroll
  #   MOZ_USE_XINPUT2 = 1;
  # };

  environment.variables = {
	  WLR_RENDERER_ALLOW_SOFTWARE = 1;
		#WLR_NO_HARDWARE_CURSORS = 1;
		#NIXOS_OZONE_WL = 1;
    #"QT_STYLE_OVERRIDE" = pkgs.lib.mkForce "adwaita-dark";

		XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
		XDG_SESSION_DESKTOP = "Hyprland";

    QT_QPA_PLATFORM = "wayland;xcb";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    #QT_QPA_PLATFORMTHEME = "qt6ct";
		QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
		QT_AUTO_SCREEN_SCALE_FACTOR = 1;

		GDK_SCALE = 1;
		GDK_BACKEND = "wayland,x11,*";
	  CLUTTER_BACKEND = "wayland";

		MOZ_ENABLE_WAYLAND =1;
    MOZ_USE_XINPUT2 = 1;
  };

  # ---------------------------------

  # X11 SETTINGS
  services.greetd = {
	  enable = true;
		settings = {
			default_session = let
			  tuigreet = "${lib.getExe pkgs.greetd.tuigreet}";
				#baseSessionsDIr = "${config.services.xserver.displayManager.sessionData.desktops}";
				#xSessions = "${baseSessionsDir}/share/xsessions";
				#waylandSessions = "${baseSessionDir}/share/wayland-sessions";
				tuigreetOptions = [
				  # "--remember"
					# "--remember-session"
					# "--sessions ${waylandSessions}:${xSessions}";
				  "--time"
					"--theme 'border=lightblue;prompt=green;time=orange;button=yellow;container=black'"
					"--cmd Hyprland"
					"-g 'Authorized Personnel Only'"
				];

				flags = lib.concatStringsSep " " tuigreetOptions;
			in {
			  command = "${tuigreet} ${flags}";
			  user = "greeter";
			};

		 #  default_session = {
			#   command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland -g 'Authorized Personnel Only' --theme border=lightblue\;prompt=green\;time=orange\;button=yellow";
			# 	user = "greeter";
			# };
		};
	};

  programs.hyprland = {
	  enable = true;
		xwayland.enable = true;
    systemd.setPath.enable = true;
	};

  services.logind.extraConfig = ''
    IdleActionSec=900
    IdleAction=suspend-then-hibernate
    HandleLidSwitch=suspend-then-hibernate
    HandleLidSwitchDocked=ignore
    HandleLidSwitchExternalPower=suspend
  '';

  systemd.sleep.extraConfig = ''
    AllowSuspend = yes
    AllowHibernate = yes
    AllowSuspendThenhibernate = yes
    AllowHybridSleep = yes

    HibernateDelaySec = 600
  '';

  # ---------------------------------

  # SECURITY

  # Security / Polkit
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    })
  '';
  security.pam.services.hyprlock = {
    text = ''
      auth include login
    '';
  };

  programs.gnupg.agent = {
	  enable = true;
		#enableSSHSupport = true;
	  pinentryPackage = lib.mkForce pkgs.pinentry-gnome3;
	};

  # DBus Setup
	services.gnome.gnome-keyring.enable = true;

  # ---------------------------------

  xdg.autostart.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ 
		  pkgs.xdg-desktop-portal
		  pkgs.xdg-desktop-portal-gtk 
		  #pkgs.xdg-desktop-portal-xapp
		  pkgs.xdg-desktop-portal-hyprland
		];
    xdgOpenUsePortal = true;
    #config.common.default = "*";
    config.common.default = [ "hyprland" "gtk" ];
		config.common."org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
  };

  # ---------------------------------

  programs = {
    dconf.profiles.user.databases = [
      {
        settings = with lib.gvariant; {
				  "org/nemo/plugins" = {
					  disabled-actions = [ 
						  "set-as-background.nemo_action" 
							"change-background.nemo_action" 
						];
					};

          "org/nemo/preferences" = {
					  thumbnail-limit = "uint64 1073741824";
					};

					"org/nemo/window-state" = {
					  maximized = true;
						sidebar-bookmark-breakpoint = "0";
						start-with-sidebar = true;
					};
        };
      }
    ];

    # nautilus-open-any-terminal = {
    #   enable = true;
    #   terminal = "kitty";
    # };

    file-roller.enable = true;
    gnome-disks.enable = true;
    seahorse.enable = true;
    udevil.enable = true;
  };

  # ---------------------------------

  # SYSTEM PACKAGES 
  environment.systemPackages = with pkgs; [
    # waybar
    (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
    )

		# grimblast
    # slurp                # Screenshots

    glib                 # Set GTK theme settings
    calcurse             # TUI Calendar app
		udiskie
		pulsemixer

		cliphist

    greetd.tuigreet      # Greeter

    #mako                 # Notification daemon
    dunst
    libnotify            # Notification libraries
    libinput-gestures    # Gesture Control

		#pyprland
		
		hyprpicker
		hyprcursor
		hyprlock
		hypridle
		hyprpaper
		#hyprutils
 
		swww
		imv 	# image viewer
		mpv   # video viewer

		waybar
		waypaper
		wdisplays
		wlr-randr
    wlogout              # Logout/shutdown/hibernate/lock screen modal UI
    wl-clipboard         # Clipboard
    rofi-wayland         # App Launcher
    #kanshi   # wayland autorndr

    # swayidle             # Idle management daemon - Automatic lock screen
		# swaylock
    swayosd              # used for on-screen notifications for things like adjusting backlight, volume, etc
		swayimg

		nwg-look     			# Theme changer
    nwg-displays			# Monitor display configuration

    # wayland-packages
		pkgs-unstable.wayprompt

    #gnome.nautilus
		#gnome.zenity
		#polkit_gnome
		#themechanger

		cinnamon.nemo
		cinnamon.nemo-with-extensions
		cinnamon.nemo-emblems
		cinnamon.nemo-fileroller
		cinnamon.folder-color-switcher
		#cinnamon.pix
		#cinnamon.xviewer
		#cinnamon.xreader

    #blueman

    kitty
    
    firefox
    thunderbird
    
    keepassxc
    keepass-charactercopy
    git-credential-keepassxc
  ] ++ (if (system == "x86_64-linux")
	        then [ pkgs.freeoffice pkgs.spotify ]
				else 
			  (if (system == "aarch64-linux" )
			    then [] 
				else []));

  # ---------------------------------

  # FONTS
  fonts.fontconfig.enable = true;
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    # dejavu_fonts
    # fira-code-nerdfont
    font-awesome
    #jetbrains-mono
    nerdfonts
    #noto-fonts
    #noto-fonts-emoji
  ];
}
