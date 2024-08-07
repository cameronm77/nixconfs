{ pkgs, ... }:

  # Enable the OpenSSH daemon.
    services.openssh.enable = true;
    services.flatpak.enable = true;
    services.pcscd.enable = true;
    services.fwupd.enable = true;
    security.pam.services = {
      login.u2fAuth = true;
      sudo.u2fAuth = true;
    };
    security.pam.yubico = {
      enable = true;
    #  debug = true;
      control = "sufficient";
      mode = "challenge-response";
      id = [ "22532244" ];
      challengeResponsePath = "/var/yubico";
      
    };

    security.pam.services.login.enableKwallet = true;

    services.udev.extraRules = ''
         ACTION=="remove",\
          ENV{ID_BUS}=="usb",\
          ENV{ID_MODEL_ID}=="0407",\
          ENV{ID_VENDOR_ID}=="1050",\
          ENV{ID_VENDOR}=="Yubico",\
          RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
     '';
    #security.duosec = {
      #ssh.enable = true;
      #pam.enable = true;
      #integrationKey = "DIXOWSN23FRF9AZY8MED";
      #secretKeyFile = "/run/keys/duo_skey";
      #host = "api-124e8e0f.duosecurity.com";
      #failmode = "safe";
      #pushinfo = true;
      #autopush = true;
    #};
