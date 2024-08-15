{ pkgs, stable, unstable, lib, systemSettings, ... }:

{
  # Setup user sharing...
  # > sudo groupadd -r sambashare
  # > sudo mkdir /var/lib/samba/usershares
  # > sudo chown root:sambashare /var/lib/samba/usershares
  # > sudo gpasswd sambashare -a ejvend
  #
  # Setup public share folder...
  # > sudo mkdir /share
  # > sudo chmod 1777 share
  #
  # To add user share from CLI do the following...
  # > net usershare add <sharename> abspath [comment] [user:{R|D|F}] [guest_ok={y|n}]
  # > net usershare delete sharename
  # > net usershare list wildcard-sharename
  # > net usershare info wildcard-sharename

  services.samba = {
    enable = true;
    package = pkgs.samba;
    #package = pkgs.samba4Full; # For full nmbd 
    securityType = "user";
    extraConfig = ''
      ;workgroup = WORKGROUP
      server string = ${systemSettings.hostname}
      netbios name = ${systemSettings.hostname}
      security = user
      map to guest = bad user
      guest account = nobody

      ;guest ok = yes
      ;map to guest = bad user
      ;syncPasswordsByPam = true;

      ;unix password sync = Yes
      ;use sendfile = yes
      ;max protocol = smb2
      ;hosts allow = 192.168.1. 127.0.0.1 localhost
      ;hosts deny = 0.0.0.0/0

      ;load printers = yes
      ;printing = cups
      ;printcap name = cups
      ;client min protocol = CORE
      ;client max protocol = smb3

      ;create mask = 0664
      ;directory mask = 2755
      ;force create mode = 0644
      ;force directory mode = 2755

      usershare path = /var/lib/samba/usershares
      usershare max shares = 100
      usershare allow guests = yes
      usershare owner only = yes
    '';
    shares = {
      nobody = {
        browsable = "no";
      };
      homes = {
        browsable = "yes";
      	writeable = "yes";
	      "guest ok" = "no";
      };
      shared = {
	      path = "/share";
        browseable = "yes";
        public = "yes";
        writable = "yes"; 
        printable = "no";
        "only guest" = "yes";
      	#"create mask" = "0644";
      	#"directory mask" = "0755";
      };
      printers = {
        path = "/var/spool/samba";
      	browsable = "no";
      	writeable = "no";
      	printable = "yes";
      	"guest ok" = "yes";
      };
    };
    openFirewall = true;
  };
  networking.firewall.allowedTCPPorts = [ 445 139 ];
  networking.firewall.allowedUDPPorts = [ 137 138 ];

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  systemd.tmpfiles.rules = [
    "d /var/spool/samba 1777 root root -"
  ];

  environment.systemPackages = with pkgs; [
    cifs-utils
    keyutils
  ];

  security.wrappers."mount.cifs" = {
    program = "mount.cifs";
    source = "${lib.getBin pkgs.cifs-utils}/bin/mount.cifs";
    owner = "root";
    group = "root";
    setuid = true;
  };
}
