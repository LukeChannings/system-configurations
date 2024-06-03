{ inputs, globals, ... }:
let
  systemConfig = globals // {

    networking.hostName = "nixos-utm";
    fonts.enable = true;

    shell.defaultShell = "fish";
    shell.defaultEditor = "helix";

    shell.git.enable = true;
    shell.starship.enable = true;
    shell.zsh.enable = true;
    shell.nushell.enable = true;
    shell.fzf.enable = true;
    shell.editorconfig.enable = true;
    shell.atuin.enable = true;
    shell.direnv.enable = true;
    shell.bat.enable = true;
    shell.ssh.enable = true;
    shell.htop.enable = true;
    shell."1password".enable = true;

    apps.vscode.enable = true;
    apps.vim.enable = true;
    apps.wezterm.enable = true;
    apps.helix.enable = true;
  };
in inputs.nixpkgs.lib.nixosSystem {
  # A lot of times online you will see the use of flake-utils + a
  # function which iterates over many possible systems. My system
  # is x86_64-linux, so I'm only going to define that
  system = "aarch64-linux";

  modules = [
    /etc/nixos/hardware-configuration.nix
    ({ pkgs, ... }: {
      system.stateVersion = "24.05";

      environment.systemPackages = [ ];
      environment.sessionVariables.NIXOS_OZONE_WL = "1";

      users.users.luke = {
        isNormalUser = true;
        description = "luke";
        extraGroups = [ "networkmanager" "wheel" ];
      };

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.networkmanager.enable = true;

      time.timeZone = "Europe/London";

      i18n.defaultLocale = "en_GB.UTF-8";
      console.useXkbConfig = true;

      sound.enable = true;

      programs.sway.enable = true;

      services.spice-vdagentd.enable = true;
      services.qemuGuest.enable = true;

      services = {
        # Ensure gnome-settings-daemon udev rules are enabled.
        udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
        xserver = {
          # Required for DE to launch.
          enable = true;

          # Enable Desktop Environment.
          desktopManager.pantheon.enable = true;

          # Configure keymap in X11.
          xkb = {
            layout = "gb(mac)";
          };
          
          # Exclude default X11 packages I don't want.
          excludePackages = with pkgs; [
            xorg.xorgserver.out
            xorg.xrandr
            xorg.xrdb
            xorg.iceauth
            xorg.xlsclients
            xorg.xset
            xorg.xsetroot
            xorg.xinput
            xorg.xprop
            xorg.xauth
            pkgs.xterm
            xorg.xf86inputevdev.out
          ];
        };

        pantheon = {
          apps.enable = false;
        };
      };
    })
    systemConfig
    ../modules/common
    inputs.home-manager.nixosModules.home-manager
    inputs._1password-shell-plugins.nixosModules.default
  ];
}
