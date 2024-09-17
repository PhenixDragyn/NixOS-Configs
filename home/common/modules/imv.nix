{ ... }:

{
  programs.imv = {
    enable = true;
    settings = {
		  binds."Ctrl+w" = ''exec swww img "$imv_current_file"'';
    };
  };
}
