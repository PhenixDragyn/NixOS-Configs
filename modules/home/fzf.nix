{ config, lib, ... }:

{
  programs.fzf = {
	  enable = true;
		enableZshIntegration = true;
		defaultOptions = [
		  "--height 40%"
			"--layout reverse"
			"--color bw"
			"--no-scrollbar"
			"--no-separator"
		];
		defaultCommand = "rg -L --files";
		changeDirWidgetCommand = "fd --type d";
	};

  programs.fzf.colors = with config.lib.stylix.colors.withHashtag; {
		"bg" = "${base00}";
		"bg+" = "${base01}";
		"fg" = "${base04}";
		"fg+" = "${base06}";
		"header" = "${base0D}";
		"hl" = "${base0D}";
		"hl+" = "${base0D}";
		"info" = "${base0A}";
		"marker" = "${base0C}";
		"pointer" = "${base0C}";
		"prompt" = "${base0A}";
		"spinner" = "${base0C}";
  };
}

