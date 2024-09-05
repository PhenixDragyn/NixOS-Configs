{ pkgs, sops-nix,  ... }: {
  default = pkgs.mkShell {
    NIX_CONFIG = "experimental-features = nix-command flakes";
    # imports all files ending in .asc/.gpg
    sopsPGPKeyDirs = [ 
      "keys/hosts"
      "keys/users"
    ];
    
    nativeBuildInputs = [
      pkgs.nix
      pkgs.git
      pkgs.vim
      pkgs.ssh-to-pgp
      (pkgs.callPackage sops-nix {}).sops-import-keys-hook
    ];

    shellHook = ''
      echo ">>>> Entering Nix Development Environment"
    '';
  };
}
