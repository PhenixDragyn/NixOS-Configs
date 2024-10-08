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
  				