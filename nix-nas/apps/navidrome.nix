{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  domain = "nixos.taila654ac.ts.net";
  navidromePort = 4533;
in
{
  # Navidrome music server
  services.navidrome = {
    enable = true;
    musicFolder = "/mnt/storage/music";
    dataFolder = "/var/lib/navidrome";

    address = "127.0.0.1";
    port = navidromePort;
    openFirewall = false;

    enableScanWatcher = true;
    baseUrl = "https://${domain}:${toString navidromePort}";

    # settings = { } -> configure the rest from the web UI
  };

  # Ensure the music directory exists with correct ownership
  systemd.tmpfiles.rules = [
    "d /mnt/storage/music 0755 navidrome navidrome -"
  ];

  # Reverse proxy on a separate TLS port, reusing the Tailscale certificate
  services.nginx.virtualHosts."navidrome" = {
    serverName = domain;
    addSSL = true;

    listen = [
      {
        addr = "0.0.0.0";
        port = navidromePort;
        ssl = true;
      }
    ];

    sslCertificate = "/var/lib/tailscale/certs/${domain}.crt";
    sslCertificateKey = "/var/lib/tailscale/certs/${domain}.key";

    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString navidromePort}";
      proxyWebsockets = true;
      recommendedProxySettings = true;
    };
  };
}