{ ... }:

{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 0;
        follow = "mouse";
        transparency = 26;
        width = 300;
        origin = "bottom-right";
        offset = "15x15";
        notification_limit = 0;
        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
        indicate_hidden = "yes";
        format = "<b>%s </b>\\n%b";
        alignment = "center";
        vertical_alignment = "center";
        show_age_threshold = 60;
        ellipsize = "middle";
        ignore_newline = "no";
        stack_duplicates = "true";
        hide_duplicate_count = "false";
        show_indicators = "yes";
        frame_color = "";
        frame_width = 2;
        geometry = "500x5-5+30";
        horizontal_padding = 8;
        icon_position = "left";
        min_icon_size = 32;
        max_icon_size = 32;
        line_height = 3;
        markup = "full";
        padding = 8;
        separator_height = 2;
        word_wrap = true;
        shrink = "no";
        text_icon_padding = 0;
        sort = "yes";
        idle_threshold = 0;
        sticky_history = "yes";
        history_length = 50;
        corner_radius = 0;
        mouse_left_click = "do_action, close_current";
        mouse_middle_click = "close_all";
        mouse_right_click = "close_current";
      };

      shortcuts = {
        context = "mod4+grave";
        close = "mod4+shift+space";
      };

      spotify = {
        appname = "Spotify";
        skip_display = "true";
        script = "spotify-notification";
      };
    };
  };
}
