{...}: 

{
    home.file = {
        ".config/waybar/scripts/tailscale.sh" = {
            enable = true;
            executable = true;
            text = ''
#!/usr/bin/env bash
CLASS=`tailscale status --json | fx . '.BackendState'`
# Known values:  Running, Stopped

# Expected Output:
# {"text": "$text", "alt": "$alt", "tooltip": "$tooltip", "class": "$class", "percentage": $percentage }
# Different $Class depending on if TS is running or not
if [ $CLASS == "Running" ]; then
		IP=`tailscale status --json | fx . '.TailscaleIPs[0]'`
		TOOLTIP="IP:  $IP"
		printf '{"class": "%s", "tooltip": "%s", "alt": "%s"}\n' "$CLASS" "$TOOLTIP" "$CLASS"
fi
if [ $CLASS == "Stopped" ]; then
		TOOLTIP="Tailscale is not running"
		printf '{"class": "%s", "tooltip": "%s", "alt": "%s"}\n' "$CLASS" "$TOOLTIP" "$CLASS"
fi
  				'';
        };
				".config/waybar/scripts/nix-updatecheck.sh" = {
				    enable = true;
						executable = true;
						text = ''
#!/usr/bin/env bash

#This script assumes your flake is in ~/.dotfiles and that your flake's nixosConfigurations is named the same as your $hostname
updates="$(cd ~/NixOS && nix flake lock --update-input nixpkgs && nix build .#nixosConfigurations.$HOSTNAME.config.system.build.toplevel && nvd diff /run/current-system ./result | grep -e '\[U' | wc -l)"

alt="has-updates"
if [ $updates -eq 0 ]; then
		alt="updated"
fi

tooltip="System updated"
if [ $updates != 0 ]; then
	tooltip=$(cd ~/.dotfiles && nvd diff /run/current-system ./result | grep -e '\[U' | awk '{ for (i=3; i<NF; i++) printf $i " "; if (NF >= 3) print $NF; }' ORS='\\n' )
fi
								
echo "{ \"text\":\"$updates\", \"alt\":\"$alt\", \"tooltip\":\"$tooltip\" }"
						'';
				};
    };
}

