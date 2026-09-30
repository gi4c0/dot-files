{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  domain = "nixos.taila654ac.ts.net";
  jellyfinPort = 8920;
  jellyfinBackendPort = 8096;
in
{
  # Jellyfin media server. Binds 0.0.0.0:8096, but the firewall only
  # allows port 22, so it is only reachable over Tailscale;
  # anything not set here can be configured from the web UI.
  services.jellyfin = {
    enable = true;
    openFirewall = false;
  };

  # Hardware transcoding (Intel QuickSync): allow access to the GPU
  users.users.jellyfin.extraGroups = [ "render" "video" ];

  # Media library location
  systemd.tmpfiles.rules = [
    "d /mnt/storage/media 0755 jellyfin jellyfin -"
  ];

  # Reverse proxy on a separate TLS port, reusing the Tailscale certificate
  services.nginx.virtualHosts."jellyfin" = {
    serverName = domain;
    addSSL = true;

    listen = [
      {
        addr = "0.0.0.0";
        port = jellyfinPort;
        ssl = true;
      }
    ];

    sslCertificate = "/var/lib/tailscale/certs/${domain}.crt";
    sslCertificateKey = "/var/lib/tailscale/certs/${domain}.key";

    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString jellyfinBackendPort}";
      proxyWebsockets = true;
      recommendedProxySettings = true;
      extraConfig = ''
        # Streaming keeps connections open for a long time
        proxy_read_timeout 600s;
        proxy_send_timeout 600s;
      '';
    };
  };
}
