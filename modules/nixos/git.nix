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

  zsh.shellAliases = {
 		gs="git status";
		ga="git add -A";
		gc="git commit -m";
		gpull="git pull origin";
		gpush="git push -u origin";
		gd="git diff * | bat";
		gl="git log --stat --graph --decorate --oneline";
  };
} 
