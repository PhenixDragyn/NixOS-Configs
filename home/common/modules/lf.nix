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
      #dragan-out = ''%${pkgs.xdragon}/bin/xdragon -z- x "$fx"'';
		 	editor-open = ''$$EDITOR $f'';

      mkdir = ''%mkdir "$@"'';
			touch = ''%touch "$@"'';

		# 	mkdir = ''
  #       ''${{
		# 		  printf "Directory Name: "
		# 			read DIR
		# 			mkdir $DIR
		# 		}}
		# 	'';
		# 	remove = ''
  #       ''${{
  #         if [ -z $fs ]; then
  #           rm -fr $f
		# 			else
		# 					IFS=':'; echo $fs | tr " " "\n"
		# 					echo 'delete? [y/n]'
		# 					read ans
		#
		# 					[ $ans = 'y' ] && (echo 'deleting files...' && rm -fr $fs) || (echo 'cancelled...')
  #         fi
		# 		}}
		# 	'';
		};
		
		keybindings = {
		# 		"\\\"" = "";
		 		#o = "";
        #x = ''''$"$f"'';
        #X = ''!"$f"'';
        J = '':updir; set dironly true; down; set dironly false; open'';
        K = '':updir; set dironly true; up; set dironly false; open'';
        dD = "delete";

        gW = ''cd ${config.home.homeDirectory}/Wallpapers'';

		 		"." = "set hidden!";
		# 		"`" = "mark-load";
		# 		"\\'" = "mark-load";
		 		"<enter>" = "open";
		# 		
		# 		do = "dragon-out";
		#
		# 		#d = "remove";
		# 		#dd = "remove";
		# 		dD = "push :remove";
		# 		
		# 		"g~" = "cd";
		# 		gh = "cd";
		# 		"g/" = "/"; ee = "editor-open";
		# 		V = ''$${pkgs.bat}/bin/bat --paging=always --theme=gruvbox "$f"'';
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
