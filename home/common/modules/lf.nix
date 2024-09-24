{ config, pkgs, ... }:

{  
  xdg.configFile."lf/icons".source = ./lf/icons;

  programs.lf = {
    enable = true;
		settings = {
				preview = true;
				hidden = false;
				drawbox = true;
				icons = true;
				ignorecase = true;
				ifs = "\\n";
		};

		commands = {
      mkdir = ''%mkdir "$@"'';
			touch = ''%touch "$@"'';

      drag-out = ''%${pkgs.ripdrag}/bin/ripdrag -a -x "$fx"'';
      editor-open = ''$$EDITOR "$f"'';
      edit-dir = ''$$EDITOR .'';
      mkdirfile = ''
        ''${{
            printf "File: "
            read DIR
            mk $DIR
        }}
      '';

      #on-cd = ''
      #  ''${{ }}
      #'';
		};
		
		keybindings = {
	    "\\\"" = "";
      o = "";
      d = "";
      e = "";
      f = "";
      c = "mkdirfile";
      "." = "set hidden!";
      D = "delete";
      p = "paste";
      dd = "cut";
      y = "copy";
      "`" = "mark-load";
      "\\'" = "mark-load";
      "<enter>" = "open";
      a = "rename";
      r = "reload";
      C = "clear";
      U = "unselect";

      do = "drag-out";

      "g~" = "cd";
      gh = "cd";
      "g/" = "/";
      gd = "cd ~/Downloads";
      gt = "cd /tmp";
      gv = "cd ~/Videos";
      go = "cd ~/Documents";
      gc = "cd ~/.config";
      gn = "cd ~/nixconf";
      gp = "cd ~/Projects";
      gs = "cd ~/.local/share";
      gm = "cd /run/media";
      gw = ''cd ${config.home.homeDirectory}/Wallpapers'';

      # go to impermanence dir
      gH = "cd /persist/users/${config.home.homeDirectory}";

      ee = "editor-open";
      "e." = "edit-dir";
      V = ''''$${pkgs.bat}/bin/bat --paging=always --theme=gruvbox "$f"'';

      "<C-d>" = "5j";
      "<C-u>" = "5k";	 		

      J = '':updir; set dironly true; down; set dironly false; open'';
      K = '':updir; set dironly true; up; set dironly false; open'';
		};

		extraConfig = 
		let 
			previewer = 
					pkgs.writeShellScriptBin "pv.sh" ''
					file=$1
					w=$2
					h=$3
					x=$4
					y=$5
					
					if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$file")" =~ ^image ]]; then
							${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
							exit 1
					fi
					
					${pkgs.pistol}/bin/pistol "$file"
				'';
				cleaner = pkgs.writeShellScriptBin "clean.sh" ''
					${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
				'';
		in
			''
				set cleaner ${cleaner}/bin/clean.sh
				set previewer ${previewer}/bin/pv.sh
			'';
  };

}
