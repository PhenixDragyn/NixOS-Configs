{ ... }:

{
  programs.zsh = {
    enable = true;
    #dotDir = ".config/zsh";
    shellAliases = {
			#fm="ranger";
			fm="yazi";

      fetch="fastfetch --config ~/.config/fastfetch/fastfetch.jsonc";
      fastfetch="fastfetch --config ~/.config/fastfetch/fastfetch.jsonc";
    };

    initExtra = ''
		  # VI Mode
      set -o vi
   
      #WORDCHARS=''${WORDCHARS//[\/.$\~#=]} # Remove '/' '.' '$' '~' '#' '=' from WORDCHARS (makes jumping and deleting whole words easier)

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
