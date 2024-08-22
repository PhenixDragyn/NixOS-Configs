{ config, lib, pkgs, stable, unstable, buildSettings, ... }:

{
  #services.udev.extraRules = ''
  #  ACTION=="change", SUBSYSTEM=="drm", RUN+="${pkgs.autorandr}/bin/autorandr -c"
  #'';

  programs.autorandr = {
    enable = true;

    profiles = {
      "laptop" = {
        fingerprint = {
          "eDP-1" = "00ffffffffffff0009e51d09000000000d1e0104951f117802ef35955d59942a215054000000010101010101010101010101010101013a398004713828403020360035ae1000001ac82d8004713828403020360035ae1000001a000000fe005743444858804e5631344e344e000000000000412199001000000a010a20200094";
        };
        config = {
          "eDP-1" = {
            enable = true;
            primary = true;
            position = "0x0";
            mode = "1920x1080";
          };
        };
      };

      # "laptop-home" = {
      #   fingerprint = {
      #     "eDP-1" = "00ffffffffffff0009e51d09000000000d1e0104951f117802ef35955d59942a215054000000010101010101010101010101010101013a398004713828403020360035ae1000001ac82d8004713828403020360035ae1000001a000000fe005743444858804e5631344e344e000000000000412199001000000a010a20200094";
      #     "DP-1" = "";
      #   };
      #   config = {
      #     "eDP-1" = {
      #       enable = true;
      #       primary = true;
      #       position = "";
      #       mode = "1920x1080";
      #     };
      #     "DP-1" = {
      #       enable = true;
      #       primary = false;
      #       position = "0x0";
      #       mode = "";
      #     };
      #   };
      # };
      #
      "laptop-work" = {
        fingerprint = {
          "eDP-1" = "00ffffffffffff0009e51d09000000000d1e0104951f117802ef35955d59942a215054000000010101010101010101010101010101013a398004713828403020360035ae1000001ac82d8004713828403020360035ae1000001a000000fe005743444858804e5631344e344e000000000000412199001000000a010a20200094";
          "DP-1" = "00ffffffffffff0010aceca04c5530312c1c0104b53d23783eee95a3544c99260f5054a54b00714f8180a9c0a940d1c0e100d10001014dd000a0f0703e8030203500615d2100001a000000ff00344b3858373841533130554c0a000000fc0044454c4c205532373138510a20000000fd0031560a8936000a20202020202001b702031df150101f200514041312110302161507060123091f0783010000565e00a0a0a0295030203500615d2100001aa36600a0f0701f8030203500615d2100001a4dd000a0f0703e8030203500615d2100001a023a801871382d40582c2500615d2100001ebf1600a08038134030203a00615d2100001a00000000000000004a";
        };
        config = {
          "eDP-1" = {
            enable = true;
            primary = true;
            position = "260x1440";
            mode = "1920x1080";
          };
          "DP-1" = {
            enable = true;
            primary = false;
            position = "0x0";
            mode = "2560x1440";
          };
        };
      };


    };
  };
}
