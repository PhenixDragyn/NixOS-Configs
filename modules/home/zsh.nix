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
		  # VI Mode
      set -o vi
   
      WORDCHARS=''${WORDCHARS//[\/.$\~#=]} # Remove '/' '.' '$' '~' '#' '=' from WORDCHARS (makes jumping and deleting whole words easier)

	    # ZSH Options
      setopt hist_verify          # command by history expansion (e.g., !!) will first be shown
      setopt correct              # try to suggest spelling of commands (first word)
      setopt no_clobber           # Prevent overriding files using `>` or `>>`, to force overriding do `>|`
      setopt interactive_comments # allows writing shell comments in interactive sessions
      setopt auto_menu            # show completion menu after second <TAB> press
      unsetopt menu_complete      # don't show completion menu on first <TAB> press
      setopt complete_in_word     # allow completion within a word
      setopt always_to_end        # automatically moves the cursor to the end of the word

      # Completion config
      ## enable menu select
      zstyle ':completion:*:*:*:*:*' menu select
      ## case insensitive & hyphen sensitive completion
      zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'
      ## match . & .. dirs
      zstyle ':completion:*' special-dirs true
      ## enable colors
      zstyle ':completion:*' list-colors ' '
      ## cache
      zstyle ':completion:*' use-cache yes
      zstyle ':completion:*' cache-path $HOME/.cache/zsh/.zcomp-cache
      ## ignores
      zstyle ':completion:*' single-ignored show

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
