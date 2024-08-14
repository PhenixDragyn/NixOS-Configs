{
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
      X11Forwarding = true;
    };
    openFirewall = true;
  };    

  programs.ssh.startAgent = true;
  programs.ssh.extraConfig = ''
      AddKeysToAgent yes
      Compression yes
      ServerAliveInterval 5
      ServerAliveCountMax 3
      SetEnv TERM=xterm-256color
    '';
}
