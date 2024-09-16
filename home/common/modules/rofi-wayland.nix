{ config, lib, pkgs, ... }:

let
  inherit (config.lib.formats.rasi) mkLiteral;
  inherit (config.lib.stylix.colors.withHashtag) base00 base01 base05 base06 base08 base0D;

  nixos-theme = lib.mkForce {
      "*" = {
          background = mkLiteral "${base00}";
          lightbg = mkLiteral "${base01}"; 
          red = mkLiteral "${base08}";
          blue = mkLiteral "${base0D}";
          lightfg = mkLiteral "${base06}";
          foreground = mkLiteral "${base05}";

          background-color = mkLiteral "${base00}";

          separatorcolor = mkLiteral "@foreground";
          border-color = mkLiteral "@lightfg";
          selected-normal-foreground = mkLiteral "@lightbg";
          selected-normal-background = mkLiteral "@lightfg";
          selected-active-foreground = mkLiteral "@background";
          selected-active-background = mkLiteral "@blue";
          selected-urgent-foreground = mkLiteral "@background";
          selected-urgent-background = mkLiteral "@red";
          normal-foreground = mkLiteral "@foreground";
          normal-background = mkLiteral "@background";
          active-foreground = mkLiteral "@blue";
          active-background = mkLiteral "@background";
          urgent-foreground = mkLiteral "@red";
          urgent-background = mkLiteral "@background";
          alternate-normal-foreground = mkLiteral "@foreground";
          alternate-normal-background = mkLiteral "@lightbg";
          alternate-active-foreground = mkLiteral "@blue";
          alternate-active-background = mkLiteral "@lightbg";
          alternate-urgent-foreground = mkLiteral "@red";
          alternate-urgent-background = mkLiteral "@lightbg";

          base-text = mkLiteral "${base05}";
          selected-normal-text = mkLiteral "${base01}";
          selected-active-text = mkLiteral "${base00}";
          selected-urgent-text = mkLiteral "${base00}";
          normal-text = mkLiteral "${base05}";
          active-text = mkLiteral "${base0D}";
          urgent-text = mkLiteral "${base08}";
          alternate-normal-text = mkLiteral "${base05}";
          alternate-active-text = mkLiteral "${base0D}";
          alternate-urgent-text = mkLiteral "${base08}";
      };

      window = {
        transparency = "real";
        location = mkLiteral "center";
        anchor = mkLiteral "center";
        fullscreen = mkLiteral "false";
        width = mkLiteral "800px";
        x-offset = mkLiteral "0px";
        y-offset = mkLiteral "0px";
        enabled = true;
        margin = mkLiteral "0px";
        padding = mkLiteral "0px";
        border = mkLiteral "1px solid";
        border-radius = mkLiteral "0px";
        cursor = mkLiteral "default";
        border-color = mkLiteral "@border-color";
        background-color = mkLiteral "@background-color";
      };
      mainbox = {
        enabled = true;
        spacing = mkLiteral "10px";
        margin = mkLiteral "0px";
        padding = mkLiteral "40px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "0px 0px 0px 0px";
        children = ''[ "inputbar", "message", "listview", "mode-switcher" ]'';
        border-color = mkLiteral "@border-color";
        background-color = mkLiteral "transparent";
      };
      inputbar = {
        enabled = true;
        spacing = mkLiteral "10px";
        margin = mkLiteral "0px";
        padding = mkLiteral "10px";
        border = mkLiteral "0px 0px 1px 0px";
        border-radius = mkLiteral "0px";
        children = ''[ "prompt", "textbox-prompt-colon", "entry" ]'';
        border-color = mkLiteral "@border-color";
        background-color = mkLiteral "@background-color";
        text-color = mkLiteral "@normal-text";
      };
      prompt = {
        enabled = true;
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
      textbox-prompt-colon = {
        enabled = true;
        expand = false;
        str = "::";
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
      entry = { 
        enabled = true;
        cursor = mkLiteral "text";
        placeholder = "...";
        placeholder-color = mkLiteral "inherit";
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
      num-filtered-row = {
        enabled = true;
        expand = false;
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
      textbox-num-sep = {
        enabled = true;
        expand = false;
        str = "/";
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
      num-rows = {
        enabled = true;
        expand = false;
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
      case-indicator = {
        enabled = true;
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
      listview = {
        enabled = true;
        columns = 2;
        lines = 10;
        cycle = true;
        dynamic = true;
        scrollbar = true;
        layout = mkLiteral "vertical";
        reverse = false;
        fixed-height = true;
        fixed-columns = true;
        spacing = mkLiteral "5px";
        margin = mkLiteral "0px";
        padding = mkLiteral "0px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "0px";
        curser = mkLiteral "default";
        border-color = mkLiteral "@border-color";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@normal-text";
      };
      scrollbar = {
        handle-width = mkLiteral "10px";
        border-radius = mkLiteral "0px";
        background-color = mkLiteral "@background-color";
        handle-color = mkLiteral "@border-color";
      };
      element = {
        enabled = true;
        spacing = mkLiteral "10px";
        margin = mkLiteral "0px";
        padding = mkLiteral "5px 10px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "0px";
        cursor = mkLiteral "pointer";
        border-color = mkLiteral "@border-color";
        background-color = mkLiteral "@background-color";
        text-color = mkLiteral "@normal-text";
      };

      "element normal.normal" = {
        background-color = mkLiteral "@normal-background";
        text-color = mkLiteral "@normal-text";
      };

      "element normal.urgent" = {
        background-color = mkLiteral "@urgent-background";
        text-color = mkLiteral "@urgent-text";
      };

      "element normal.active" = {
        background-color = mkLiteral "@active-background";
        text-color = mkLiteral "@active-text";
      };

      "element selected.normal" = {
        background-color = mkLiteral "@selected-normal-background";
        text-color = mkLiteral "@selected-normal-text";
      };

      "element selected.urgent" = {
        background-color = mkLiteral "@selected-urgent-background";
        text-color = mkLiteral "@selected-urgent-text";
      };

      "element selected.active" = {
        background-color = mkLiteral "@selected-active-background";
        text-color = mkLiteral "@selected-active-text";
      };

      "element alternate.normal" = {
        background-color = mkLiteral "@alternate-normal-background";
        text-color = mkLiteral "@alternate-normal-text";
      };

      "element alternate.urgent" = {
        background-color = mkLiteral "@alternate-urgent-background";
        text-color = mkLiteral "@alternate-urgent-text";
      };

      "element alternate.active" = {
        background-color = mkLiteral "@alternate-active-background";
        text-color = mkLiteral "@alternate-active-text";
      };

      element-icon = {
        size = mkLiteral "24px";
        cursor = mkLiteral "inherit";
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
      element-text = {
        cursor = mkLiteral "inherit";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
        highlight = mkLiteral "inherit";
      };
      mode-switcher = {
        enabled = true;
        spacing = mkLiteral "10px";
        margin = mkLiteral "0px";
        padding = mkLiteral "0px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "0px";
        border-color = mkLiteral "inherit";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
      };
      button = {
        padding = mkLiteral "5px 10px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "0px";
        cursor = mkLiteral "pointer";
        border-color = mkLiteral "inherit";
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
      "button selected" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
      message = {
        enable = true;
        margin = mkLiteral "0px";
        padding = mkLiteral "0px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "0px 0px 0px 0px";
        border-color = mkLiteral "inherit";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
      };
      textbox = {
        padding = mkLiteral "5px 10px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "0px";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
        highlight = mkLiteral "none";
        blink = true;
        markup = true;
        border-color = mkLiteral "inherit";
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
        placeholder-color = mkLiteral "inherit";
      };
      error-message = {
        padding = mkLiteral "10px";
        border = mkLiteral "2px solid";
        border-radius = mkLiteral "0px";
        border-color = mkLiteral "inherit";
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
    };

  in {
    home.file.".config/rofi/powermenu".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/common/modules/rofi/powermenu";

    programs.rofi = {
      package = pkgs.rofi-wayland;
      enable = true;
      theme = nixos-theme;

      extraConfig = {
        modi = "drun,run,filebrowser";
        font = "Fira Code Nerd Font 10";
        icon-theme = "Papirus-Dark";
        case-sensitive = false;
        cycle = true;
        filter = "";
        scroll-method = 0;
        normalize-match = true;
        show-icons = true;
        steal-focus = false;
        matching = "normal";
        tokenize = true;
        ssh-client = "ssh";
        ssh-command = "{terminal} -e {ssh-client} {host} [-p {port}]";
        parse-hosts = true;
        parse-known-hosts = true;
        drun-categories = "";
        drun-match-fields = "name,generic,exec,categories,keywords";
        drun-display-format = "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
        drun-show-actions = false;
        drun-url-launcher = "xdg-open";
        drun-use-desktop-cache = false;
        drun-reload-desktop-cache = false;
        run-command = "{cmd}";
        run-list-command = "";
        run-shell-command = "{terminal} -e {cmd}";
        window-match-fields = "title,class,role,name,desktop";
        window-command = "wmctrl -i -R {window}";
        window-thumbnail = false;
        disable-history = false;
        sorting-method = "normal";
        max-history-size = 25;
        display-drun = " Apps";
        display-run = " Run";
        display-filebrowser = " Files";
        display-window = " Windows";
        window-format = "{w} · {c} · {t}";
        terminal = "rofi-sensible-terminal";
        sort = false;
        threads = 0;
        click-to-exit = true;
        kb-row-up = "Up,Control+k,Shift+Tab,Shift+ISO_Left_Tab";
        kb-row-down = "Down,Control+j";
        kb-row-left = "Left,Control+h";
        kb-row-right = "Right,Control+l";
        kb-accept-entry = "Control+m,Return,KP_Enter";
        kb-remove-to-eol = "Control+Shift+e";
        kb-move-char-back = "Control+b";
        kb-move-char-forward = "Control+f";
        kb-mode-next = "alt+l";
        kb-mode-previous = "alt+h";
        kb-mode-complete = "";
        kb-remove-char-back = "BackSpace";
      };
    };
  }
}

