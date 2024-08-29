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
          "eDP-1" = "00ffffffffffff0006afa40b0000000000200104a51e137803adf5a854479c240e505400000001010101010101010101010101010101f06800a0a0402e60302035002dbc1000001af35300a0a0402e60302035002dbc1000001a000000fe00383944474680423134305141580000000000024121a8000100001a410a202000a8";
        };
        config = {
          "eDP-1" = {
            enable = true;
            primary = true;
            position = "0x0";
            mode = "2560x1600";
          };
        };
      };

      # "laptop-home" = {
      #   fingerprint = {
      #     #"eDP-1" = "00ffffffffffff0009e51d09000000000d1e0104951f117802ef35955d59942a215054000000010101010101010101010101010101013a398004713828403020360035ae1000001ac82d8004713828403020360035ae1000001a000000fe005743444858804e5631344e344e000000000000412199001000000a010a20200094";
      #     "eDP-1" = "00ffffffffffff0006afa40b0000000000200104a51e137803adf5a854479c240e505400000001010101010101010101010101010101f06800a0a0402e60302035002dbc1000001af35300a0a0402e60302035002dbc1000001a000000fe00383944474680423134305141580000000000024121a8000100001a410a202000a8";
      #     "DP-2" = "00ffffffffffff005a633b65010101012f1f0104b5502278371455a75652a0270d5054bfef80e1c0d100d1c0b300a9c0810081c00101e77c70a0d0a0295030203a00204f3100001a000000ff0057464e3231343730303136360a000000fd00304b96963c010a202020202020000000fc005647333435360a20202020202001fb020334d0580102030405060708090e0f101112131415161d1e1f20212223097f078301000065030c001000681a00000101304b008e6770a0d0a02c5030203a00204f3100001c589d70a0d0a0345030203a00204f3100001c993e70b0d3a0185080583a10204f3100001c565e00a0a0a0295030203500204f3100001e000000e4";
      #   };
      #   config = {
      #     "eDP-1" = {
      #       enable = true;
      #       primary = true;
      #       position = "3440x360";
      #       mode = "2560x1440";
      #     };
      #     "DP-2" = {
      #       enable = true;
      #       primary = false;
      #       position = "0x0";
      #       mode = "3440x1440";
      #     };
      #   };
      # };
      
      "laptop-work" = {
        fingerprint = {
          "eDP-1" = "00ffffffffffff0006afa40b0000000000200104a51e137803adf5a854479c240e505400000001010101010101010101010101010101f06800a0a0402e60302035002dbc1000001af35300a0a0402e60302035002dbc1000001a000000fe00383944474680423134305141580000000000024121a8000100001a410a202000a8";
          "DP-2" = "00ffffffffffff0010aceca04c5530312c1c0104b53d23783eee95a3544c99260f5054a54b00714f8180a9c0a940d1c0e100d10001014dd000a0f0703e8030203500615d2100001a000000ff00344b3858373841533130554c0a000000fc0044454c4c205532373138510a20000000fd0031560a8936000a20202020202001b702031df150101f200514041312110302161507060123091f0783010000565e00a0a0a0295030203500615d2100001aa36600a0f0701f8030203500615d2100001a4dd000a0f0703e8030203500615d2100001a023a801871382d40582c2500615d2100001ebf1600a08038134030203a00615d2100001a00000000000000004a";
        };
        config = {
          "eDP-1" = {
            enable = true;
            primary = true;
            position = "600x2160";
            mode = "2560x1600";
          };
          "DP-2" = {
            enable = true;
            primary = false;
            position = "0x0";
            mode = "3840x2160";
          };
        };
      };


    };
  };
}
