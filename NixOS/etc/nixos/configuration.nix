# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <nixos-hardware/microsoft/surface/common>
      <nixos-hardware/microsoft/surface/surface-pro-intel>
      <nixos-hardware/common/gpu/nvidia>
      <nixos-hardware/common/cpu/intel>
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  nix.settings.experimental-features = ["nix-command" "flakes" ];
  nix.settings.trusted-users = ["root" "cmilani" ];

  hardware.graphics.enable = true;
  hardware.nvidia.modesetting.enable = true;
  #hardware.nvidia.prime.sync.enable = true;
  hardware.nvidia.prime.offload.enable = true;
  hardware.nvidia.prime.nvidiaBusId = "PCI:3:0:0";
  hardware.nvidia.prime.intelBusId = "PCI:0:2:0";


  networking.hostName = "cameronsurface"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

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
  services.xserver.enable = false;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cmilani = {
    isNormalUser = true;
    description = "Cameron";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Install firefox.
  #programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
     surface-control
     pkgs.gh
     pkgs.steam
     pkgs.pamtester
     pkgs.sstp
     pkgs.pam_u2f
     pkgs.sherlock
     pkgs.ipscan
     pkgs.bettercap
     pkgs.gnome.seahorse
     pkgs.duo-unix
     pkgs.ssh-mitm
     pkgs.john
     pkgs.johnny
     pkgs.firefox
     pkgs.bitwarden-desktop
     pkgs.bitwarden-cli
     pkgs.intel-media-driver
     pkgs.wgnord
     pkgs.htop
     pkgs.postman
     pkgs.git
     pkgs.appimage-run
     pkgs.wget
     pkgs.kitty
     pkgs.curl
     pkgs.wine64
     pkgs.vscode
     pkgs.coreutils-full
     pkgs.dnf5
     pkgs.dnf-plugins-core
     pkgs.dog
     pkgs.doggo
     pkgs.fwupd
     pkgs.fwupd-efi
     pkgs.intel-gpu-tools
     pkgs.vaapiIntel
     pkgs.intelmetool
     pkgs.inteltool
     pkgs.iperf2
     pkgs.iperf
     pkgs.iperf3d
     pkgs.kitty-img
     pkgs.kitty-themes
     pkgs.kittysay
     pkgs.libreoffice
     pkgs.mesa
     pkgs.mesa_drivers
     pkgs.metasploit
     pkgs.microsoft-edge
     pkgs.mono
     pkgs.mtr
     pkgs.mtr-exporter
     pkgs.mtr-gui
     pkgs.networkmanager-openvpn
     pkgs.networkmanager-sstp
     pkgs.networkmanager_strongswan
     pkgs.networkmanager-vpnc
     pkgs.nmap
     pkgs.onedrive
     pkgs.onedrivegui
     pkgs.pciutils
     pkgs.jdk22
     pkgs.openssl
     pkgs.openvpn
     pkgs.vpnc
     pkgs.winbox
     pkgs.wine64Packages.stableFull
     pkgs.wine64Packages.waylandFull
     pkgs.wineWow64Packages.waylandFull
     pkgs.wineWow64Packages.full
     pkgs.winetricks
     pkgs.wireguard-tools
     pkgs.wireshark
     pkgs.wg-netmanager
     pkgs.yubico-pam
     pkgs.yubico-piv-tool
     pkgs.yubikey-agent
     pkgs.yubikey-manager-qt
     pkgs.yubikey-personalization
     pkgs.remmina
     pkgs.firewalld
     
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };

  # List services that you want to enable:
    services.udev.packages = [
      pkgs.iptsd
      pkgs.surface-control
    ];

    systemd.packages = [
      pkgs.iptsd
    ];

  # Enable the OpenSSH daemon.
    services.openssh.enable = true;
    services.flatpak.enable = true;
    services.pcscd.enable = true;
    services.fwupd.enable = true;
    security.pam.services = {
      login.u2fAuth = true;
      sudo.u2fAuth = true;
    };
    #security.pam.yubico = {
    #  enable = true;
    #  debug = true;
    #  control = "sufficient";
    #  mode = "challenge-response";
    #  id = [ "22532244" ];
    #  challengeResponsePath = "/var/yubico";
      
    #};

    security.pam.services.login.enableKwallet = true;

    #services.udev.extraRules = ''
    #     ACTION=="remove",\
    #      ENV{ID_BUS}=="usb",\
    #      ENV{ID_MODEL_ID}=="0407",\
    #      ENV{ID_VENDOR_ID}=="1050",\
    #      ENV{ID_VENDOR}=="Yubico",\
    #      RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
    #  '';
    security.duosec = {
      ssh.enable = true;
      pam.enable = true;
      integrationKey = "DIXOWSN23FRF9AZY8MED";
      secretKeyFile = "/run/keys/duo_skey";
      host = "api-124e8e0f.duosecurity.com";
      failmode = "safe";
      pushinfo = true;
      autopush = true;
    };


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
