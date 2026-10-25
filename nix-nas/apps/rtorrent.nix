{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  watchDir = "/home/nas/Downloads/torrents";
  mediaDir = "/mnt/storage/media";
in
{
  # rTorrent daemon. Dropping a .torrent file into a watch directory starts
  # the download straight into the matching Jellyfin library folder.
  services.rtorrent = {
    enable = true;
    # Run as nas so it can read the watch dirs in /home/nas
    # (the module relaxes ProtectHome for non-default users).
    user = "nas";
    group = "users";
    downloadDir = "${mediaDir}/downloads";
    configText = ''
      # The module's template is tuned for private trackers; private
      # torrents still skip DHT/PEX because rTorrent honours their flag.
      dht.mode.set = auto
      protocol.pex.set = yes
      trackers.use_udp.set = yes

      # World-readable downloads so Jellyfin can read them
      system.umask.set = 0022

      # Check the watch dirs every 10 seconds
      schedule2 = watch_movies, 10, 10, ((load.start_verbose, (cat, "${watchDir}/movies/", "*.torrent"), "d.directory.set=${mediaDir}/movies"))
      schedule2 = watch_shows, 11, 10, ((load.start_verbose, (cat, "${watchDir}/shows/", "*.torrent"), "d.directory.set=${mediaDir}/shows"))
    '';
  };

  systemd.tmpfiles.rules = [
    "d /home/nas/Downloads 0755 nas users -"
    "d ${watchDir} 0755 nas users -"
    "d ${watchDir}/movies 0755 nas users -"
    "d ${watchDir}/shows 0755 nas users -"
    "d ${mediaDir}/downloads 0755 nas users -"
    "d ${mediaDir}/movies 0755 nas users -"
    "d ${mediaDir}/shows 0755 nas users -"
  ];
}
