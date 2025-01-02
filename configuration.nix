# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm = {
    enable = true;
    settings = {
      General.InputMethod = "qtvirtualkeyboard";
    };
  };
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  environment.sessionVariables.KWIN_IM_SHOW_ALWAYS = "1";
#   environment.sessionVariables.QT_IM_MODULE = "maliit";
  # Enable CUPS to print documents.
  services.printing.enable = true;
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableKvm = true;
  virtualisation.virtualbox.host.addNetworkInterface = false;
  users.extraGroups.vboxusers.members = [ "albert" ];
  # Accelerometer orientation; upstreaming in preogress.
  # https://github.com/systemd/systemd/pull/7752
  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  hardware.bluetooth.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  security.polkit.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  # auto gc
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  # auto update
  system.autoUpgrade = {
    enable = true;
    flake = "github:Quackification/nix-conf";
    flags = [
      "--update-input"
      "--commit-lock-file"
      "nixpkgs"
    ];
    dates = "weekly";
  };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.albert = {
    isNormalUser = true;
    description = "Albert";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.variables.EDITOR = "codium";
  environment.systemPackages = with pkgs; [
    blender
    btop
    efibootmgr
    (vscode-with-extensions.override {
      vscode = vscodium;
      vscodeExtensions = with vscode-extensions; [
        formulahendry.code-runner
        ms-python.black-formatter
        ms-python.debugpy
        ms-python.isort
        ms-python.pylint
        ms-python.python
        # java
        vscjava.vscode-java-debug
        vscjava.vscode-java-dependency
        redhat.java
        vscjava.vscode-gradle
        # nix
        jnoortheen.nix-ide
        bbenoist.nix
        # rust
        serayuzgur.crates
        tamasfe.even-better-toml
        rust-lang.rust-analyzer
        # cpp
        llvm-vs-code-extensions.vscode-clangd
        # wpi
        wpilibsuite.vscode-wpilib
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "remote-ssh-edit";
          publisher = "ms-vscode-remote";
          version = "0.47.2";
          sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
        }
      ];
    })
    gettext
    git
    glib
    gnumake
    jetbrains.clion
    jetbrains.idea-ultimate
    keyd
    libinput
    librewolf
    libreoffice
    lunar-client
    prismlauncher
    kdePackages.extra-cmake-modules
    kdePackages.qtvirtualkeyboard
    wine
    winetricks
    #cpp stuff
    clang
    clang-tools
    cmake
    codespell
    conan
    cppcheck
    doxygen
    gtest
    lcov
    vcpkg
    vcpkg-tool
    #java
    gcc
    gradle
    jdk23
    maven
    ncurses
    patchelf
    zlib
    #sddm config
    (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
    [General]
    background=${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/ScarletTree/contents/images_dark/5120x2880.png
  '')
    #hyprland
    brightnessctl
    dunst
    hyprpolkitagent
    hyprshot
    libnotify
    networkmanagerapplet
    swww
    wvkbd
];
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            "leftshift+leftmeta"="macro(M-f13)";
            rightshift="rightshift";
          };
        };
      };
    };
  };
  systemd.services.tabletmode = {
    path = [ pkgs.bash pkgs.libinput pkgs.gawk ];
    description = "disables keyd for tablet mode";
    enable = true;
    serviceConfig = {
      Type = "simple";
      ExecStart = "/etc/nixos/scripts/virtual-keyboard.sh";
    };
    wantedBy = [ "sysinit.target" ];
  };
  hardware.sensor.iio.enable = true;
  # Accelerometer orientation; upstreaming in preogress.
  # https://github.com/systemd/systemd/pull/7752
  services.udev.extraHwdb = ''
    sensor:modalias:acpi:INVN6500*:dmi:*svn*ASUSTeK*:*pn*TP300LA*
     ACCEL_MOUNT_MATRIX=0, 1, 0; 1, 0, 0; 0, 0, 1
  '';
  i18n.inputMethod = {
   type = "fcitx5";
   enable = true;
   fcitx5.waylandFrontend = true;
   fcitx5.addons = with pkgs; [
     fcitx5-chinese-addons
   ];
   fcitx5.settings.inputMethod = {
         "Groups/0" = {
      "Name" = "Default";
      "Default Layout" = "us";
      "DefaultIM" = "pinyin";
    };

    "Groups/0/Items/0" = {
      "Name" = "keyboard-us";
      "Layout" = "null";
    };

    "Groups/0/Items/1" = {
      "Name" = "pinyin";
      "Layout" = "null";
    };

    "GroupOrder" = {
      "0" = "Default";
    };
   };
  };
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      font-awesome
      nerdfonts
      noto-fonts
      noto-fonts-cjk-sans
      liberation_ttf
    ];
    fontconfig = {
      defaultFonts = {
      serif = [ "Liberation Serif" ];
      sansSerif = [ "Noto Sans CJK SC" ];
      monospace = [ "Noto Sans Mono" ];
      };
    };
  };
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
