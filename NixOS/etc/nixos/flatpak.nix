{ config, pkgs, ... }:

{
  # Flatpak und Flatpak-Repositories
  environment.systemPackages = with pkgs; [
    flatpak
  ];

  # Flatpak-Repositories
  environment.etc."flatpak/repo.d/flathub.conf".text = ''
    [remote "flathub"]
    url=https://dl.flathub.org/repo/
    gpg-verify=true
    gpg-verify-summary=true
    xa.title=Flathub
    xa.comment=Apps for all Linux devices
  '';

  # Flatpak services
  services.flatpak.enable = true;

  # Add Repo and activate
  system.activationScripts.flatpak = ''
    ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  '';

  # Flatpak-Installation
     system.activationScripts.flatpakApps = ''
     ${pkgs.flatpak}/bin/flatpak install -y flathub io.github.shiftey.Desktop
     ${pkgs.flatpak}/bin/flatpak install -y flathub md.obsidian.Obsidian
     ${pkgs.flatpak}/bin/flatpak install -y flathub com.tutanota.Tutanota
     ${pkgs.flatpak}/bin/flatpak install -y flathub org.sqlitebrowser.sqlitebrowser
     ${pkgs.flatpak}/bin/flatpak install -y flathub org.zealdocs.Zeal
     ${pkgs.flatpak}/bin/flatpak install -y flathub org.fedoraproject.MediaWriter
     ${pkgs.flatpak}/bin/flatpak install -y flathub it.mijorus.gearlever
     ${pkgs.flatpak}/bin/flatpak install -y flathub com.nextcloud.desktopclient.nextcloud
     ${pkgs.flatpak}/bin/flatpak install -y flathub one.flipperzero.qFlipper
     ${pkgs.flatpak}/bin/flatpak install -y flathub nl.brixit.wiremapper
     ${pkgs.flatpak}/bin/flatpak install -y flathub io.github.getnf.embellish
     ${pkgs.flatpak}/bin/flatpak install -y flathub com.netxms.NetXMSClient
     ${pkgs.flatpak}/bin/flatpak install -y flathub org.signal.Signal
     ${pkgs.flatpak}/bin/flatpak install -y flathub com.getpostman.Postman
     ${pkgs.flatpak}/bin/flatpak install -y flathub org.nmap.Zenmap
     ${pkgs.flatpak}/bin/flatpak install -y flathub com.github.Anuken.Mindustry
     ${pkgs.flatpak}/bin/flatpak install -y flathub com.atlauncher.ATLauncher
     ${pkgs.flatpak}/bin/flatpak install -y flathub com.heroicgameslauncher.hgl
     ${pkgs.flatpak}/bin/flatpak install -y flathub net.davidotek.pupgui2
     ${pkgs.flatpak}/bin/flatpak install -y flathub com.github.dail8859.NotepadNext

   '';
}
