{ pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        weechat
    ];

    # Per the README, set matrix-sso-helper in your $PATH
    environment.interactiveShellInit  = ''
        alias matrix_sso_helper=${pkgs.weechatScripts.weechat-matrix}/bin/matrix_sso_helper
    '';

    nixpkgs.overlays = [
        (
            self: super: {
                weechat = super.weechat.override {
                    configure = {availablePlugins, ...}: {
                        scripts = with pkgs.weechatScripts; [
                            weechat-matrix
                            weechat-go
                            weechat-notify-send
                        ];
                        plugins = builtins.attrValues availablePlugins;
                    };
                };
            }
        )
    ];
}