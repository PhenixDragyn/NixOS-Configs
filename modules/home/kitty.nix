{ ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = -0;
      copy_on_select = true;
      clipboard_control = "write-clipboard read-clipboard write-primary read-primary";
    };
  };
}
