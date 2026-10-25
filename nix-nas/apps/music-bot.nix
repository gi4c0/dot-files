# Telegram bot that searches/downloads songs into the Navidrome library.
# Source: github.com/gi4c0/music_bot (module comes from its flake).
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  # Env file with TELOXIDE_TOKEN (and optionally SPOTIFY_CLIENT_ID /
  # SPOTIFY_CLIENT_SECRET), rendered by sops-nix from secrets.yaml.
  sops.secrets."music_bot_env" = { };

  services.music-bot = {
    enable = true;
    # Own subfolder inside the Navidrome library: ScanWatcher picks new
    # songs up, and the bot never touches the rest of the library.
    downloadDir = "/mnt/storage/music/Telegram";
    # The library is navidrome:navidrome 0700, so write as navidrome too.
    user = "navidrome";
    group = "navidrome";
    allowedUsernames = [ "mr_pan4" ];
    environmentFile = config.sops.secrets."music_bot_env".path;
    ytDlpPackage = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.yt-dlp;
  };
}
