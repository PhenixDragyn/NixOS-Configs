{ ... }: 

{
  programs.git = {
    enable = true;
		lfs.enable = true;
    userName = "PhenixDragyn";
    userEmail = "ejvend.nielsen@gmail.com";

    #extraConfig = {
    #  # core.askPass = false;
    #  credential.helper = "cache --timeout=25920000";
    #  user.signingkey = "48FBC3335A26DED6";
    #  commit.gpgsign = "true";
    #};

    #extraConfig = {
    #  credential = {
    #    helper = "keepassxc --git-groups";
    #  };
    #};

    #ignores = [
    # "*.example"
    #];

		# home.packages = with pkgs: [
		#  git-crypt
		# ];
  };
} 
