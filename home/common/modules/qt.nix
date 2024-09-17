{ lib, pkgs, ... }:

{
  qt = {
    enable = true;
		style.name = "gtk2";
		platformTheme.name = "gtk2";
  };
}
