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
  navidromeBackendPort = 4534;
in
{
  # Navidrome music server
  services.navidrome = {
    enable = true;
    openFirewall = false;

    settings = {
      Address = "127.0.0.1";
      Port = navidromeBackendPort;
      MusicFolder = "/mnt/storage/music";
      DataFolder = "/var/lib/navidrome";
      BaseURL = "https://${domain}:${toString navidromePort}";
      ScanWatcher = true;
      EnableInsightsCollector = false;
    };
    # Anything not set here can be configured from the web UI.
  };

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
      proxyPass = "http://127.0.0.1:${toString navidromeBackendPort}";
      proxyWebsockets = true;
    };
  };
}