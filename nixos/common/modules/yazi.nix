{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ffmpegthumbnailer
    poppler
		ripgrep
  ];

	programs.yazi = {
		enable = true;
	};
}
