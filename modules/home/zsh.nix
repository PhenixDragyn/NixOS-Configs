{ ... }:

{
  programs.zsh = {
    enable = true;
    #dotDir = ".config/zsh";
    shellAliases = {
      nr="sudo nixos-rebuild switch --flake";
      hm="home-manager switch --flake";
      nb="nix-build --no-out-link"; 
      nbm="nom-build --no-out-link"; 
      nu="nix flake update";
      nr-pkgs="nix-store --query --requisites /run/current-system | cut -d- -f2 | sort | uniq | fzf ";
     
      # q="exit";
      # ls="lsd -F";
      # la="lsd -F -a";
      # ll="lsd -F -l";
      # lla="lsd -F -la";
      #
      # rm="rm -v";
      
      open="xdg-open";

      gs="git status";
      ga="git add -A";
      gc="git commit -m";
      gpull="git pull origin";
      gpush="git push -u origin";
      gd="git diff * | bat";
      gl="git log --stat --graph --decorate --oneline";

   #    rr="ranger";
			# lf="lf";
			# yz="yazi";
			fm="ranger";

      diff="diff --color=auto";
      grep="grep --color=auto";

      fastfetch="fastfetch --config ~/.config/fastfetch/fastfetch.jsonc";
    };

    initExtra = ''
      set -o vi
   
      # Ranger
      export RANGER_DEVICONS_SEPARATOR="  "
    '';
    
    envExtra = ''
      path=(~/.local/bin ~/.local/lib $path[@])
    '';

    #profileExtra = ''
    #'';

    history = {
      ignoreDups = true;
      ignoreSpace = true;
      save = 100000;
      share = true;
      size = 100000;
    };
  };
}
