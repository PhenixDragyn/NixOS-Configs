{ ... }:

{
  home.file = { 
    ".local/share/nautilus/scripts" = {
      source = ./nautilus/scripts;
      recursive = true;
    };
	};
}
