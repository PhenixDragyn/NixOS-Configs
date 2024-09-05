{ hostname, ... }: 

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

  # May need to run as user...
  # systemctl --user enable --now ssh-agent.service
  programs.ssh.startAgent = true;

  programs.ssh.extraConfig = ''
      AddKeysToAgent yes
      Compression yes
      ServerAliveInterval 5
      ServerAliveCountMax 3
      SetEnv TERM=xterm-256color
    '';
}
