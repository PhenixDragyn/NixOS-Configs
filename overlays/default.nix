# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  #additions = final: _prev: import ../packages final.pkgs;
  additions = final: _prev: import ../packages { pkgs = final; };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # sha256 = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    # sha256 = "0000000000000000000000000000000000000000000000000000";
    # sha256 = "0000000000000000000000000000000000000000000000000000000000000000";
    # });

    # hyprpaper = prev.hyprpaper.overrideAttrs rec {
    #   version = "0.7.1";
    #   src = prev.fetchFromGitHub {
    #     owner = "hyprwm";
    #     #repo = prev.pname;
    #     repo = "hyprpaper";
    #     rev = "v${version}";
    #     hash = "sha256-HIK7XJWQCM0BAnwW5uC7P0e7DAkVTy5jlxQ0NwoSy4M=";
    #     #sha256 = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    #   };
		# };

		cinnamon = prev.cinnamon.overrideScope (cfinal: cprev: {
			nemo = cprev.nemo.overrideAttrs (attrs: {
				preFixup = attrs.preFixup or "" + ''
					gappsWrapperArgs+=(
						--prefix XDG_DATA_DIRS : "${final.shared-mime-info}/share"
						# Thumbnailers
						--prefix XDG_DATA_DIRS : "${final.gdk-pixbuf}/share"
						--prefix XDG_DATA_DIRS : "${final.librsvg}/share"
						--prefix XDG_DATA_DIRS : "${final.webp-pixbuf-loader}/share"
						--prefix XDG_DATA_DIRS : "${final.libavif}/share"
					)
				'';
			});
		};
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
