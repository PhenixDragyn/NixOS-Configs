{ pkgs, ... }:

{
  environment.shells = with pkgs; [ zsh ];
  
  environment.systemPackages = with pkgs; [
    nix-zsh-completions
    zsh-completions
    zsh-history-substring-search
    zsh-syntax-highlighting
  ];

  programs.zsh = {
    enable = true;
    
    enableCompletion = true;
    autosuggestions.enable = true;
    zsh-autoenv.enable = true;
    syntaxHighlighting.enable = true;
    
    ohMyZsh = {
      enable = true;
      theme = "agnoster";
      #theme = "robbyrussell";

      plugins = [ "git" "python" "sudo" "history" ];
    }; 

    shellAliases = {
      nr="sudo nixos-rebuild switch --flake";
      hm="home-manager switch --flake";
      nb="nix-build --no-out-link"; 
      nbm="nom-build --no-out-link"; 
      nu="nix flake update";
      nr-pkgs="nix-store --query --requisites /run/current-system | cut -d- -f2 | sort | uniq | fzf ";

      q="exit";
      ls="lsd -F";
      la="lsd -F -a";
      ll="lsd -F -l";
      lla="lsd -F -la";

      rm="rm -v";

      rr="ranger";
			lf="lf";
			yz="yazi";

      diff="diff --color=auto";
      grep="grep --color=auto";

      open="xdg-open";
    };

    setOptions = [
      "NO_BEEP"
    ];

    interactiveShellInit = ''
      #source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    '';
  };

  fonts.packages = with pkgs; [
    powerline-fonts
  ];
 }
