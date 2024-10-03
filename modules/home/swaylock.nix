{ pkgs, ... }: 

{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = { 
      # All <color> options are of the form <rrggbb[aa]>.
      # font-size = 96;
      show-failed-attempts = true;
      effect-blur = "30x8";
      screenshots = true;

      clock = true;
      timestr = "%R";
      datestr = "%a, %b %d";
      grace = 5;

      indicator = true;
      indicator-radius = "130";
      indicator-thickness = "12";
      indicator-caps-lock = true;
      disable-caps-lock-text = false;
    };
  };
}

