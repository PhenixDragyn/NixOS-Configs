{ ... }:

{
  programs.imv = {
    enable = true;
    settings = {
		  binds "Ctrl+w" = exec swww img "$imiv_current_file"
    };
  };
