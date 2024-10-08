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
