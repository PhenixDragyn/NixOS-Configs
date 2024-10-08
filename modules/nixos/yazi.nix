{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ffmpegthumbnailer
    poppler
  ];

	programs.yazi = {
		enable = true;
	};
}
