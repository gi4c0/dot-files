{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  domain = "nixos.taila654ac.ts.net";
  immichPort = 4443;
in
{
  # Immich server
  services.immich = {
    enable = true;
    package = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.immich;
    mediaLocation = "/mnt/storage/immich";
    host = "127.0.0.1";
    openFirewall = false;

    # Hardware acceleration for transcoding (Intel QuickSync)
    accelerationDevices = [ "/dev/dri/renderD128" ];

    machine-learning.enable = true;
    # settings = null -> configure everything from the web UI
  };

  # Ensure the media directory exists with correct ownership
  systemd.tmpfiles.rules = [
    "d /mnt/storage/immich 0700 immich immich -"
  ];

  # Reverse proxy on a separate TLS port, reusing the Tailscale certificate
  services.nginx.virtualHosts."immich" = {
    serverName = domain;
    addSSL = true;

    listen = [
      {
        addr = "0.0.0.0";
        port = immichPort;
        ssl = true;
      }
    ];

    sslCertificate = "/var/lib/tailscale/certs/${domain}.crt";
    sslCertificateKey = "/var/lib/tailscale/certs/${domain}.key";

    locations."/" = {
      proxyPass = "http://127.0.0.1:2283";
      proxyWebsockets = true;
      recommendedProxySettings = true;
      extraConfig = ''
        client_max_body_size 50000M;
        proxy_read_timeout 600s;
        proxy_send_timeout 600s;
        send_timeout 600s;
      '';
    };
  };
}
