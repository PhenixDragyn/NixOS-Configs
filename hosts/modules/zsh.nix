{ pkgs, stable, unstable, ... }:

{
  environment.shells = with pkgs; [ zsh ];
  
  environment.systemPackages = with pkgs; [
    nix-zsh-completions
    zsh-completions
    zsh-history-substring-search
    zsh-syntax-highlighting
  ] ++ (if (systemSettings.system == "x86_64-linux")
	        then []
				else 
			  (if (systemSettings.system == "aarch64-linux" )
			    then [] 
				else []));

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    enableCompletion = true;
    zsh-autoenv.enable = true;
    syntaxHighlighting.enable = true;
    
    ohMyZsh = {
      enable = true;
      theme = "agnoster";
      #theme = "robbyrussell";
      plugins = [ "git" "python" "sudo" "history" ];
    }; 

    shellAliases = {
    };

    setOptions = [
      "HIST_IGNORE_SPACE"
      "NO_BEEP"
    ];

    interactiveShellInit = ''
      #source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    '';
  };

 }
