# Spend Tracker sync backend (Android expense app).
# Source: github.com/gi4c0/family_app, backend/ (module comes from its flake).
# Uses the local PostgreSQL (peer auth) and its own socket-only Redis.
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  domain = "nixos.taila654ac.ts.net";
  spendTrackerPort = 4539;
  spendTrackerBackendPort = 4540;
in
{
  # Env file with JWT_SECRET=<openssl rand -hex 32>, rendered by sops-nix from secrets.yaml.
  sops.secrets."spend_tracker_env" = { };

  services.spend-tracker = {
    enable = true;
    listenAddress = "127.0.0.1:${toString spendTrackerBackendPort}";
    photoDir = "/mnt/storage/spend-tracker/photos";
    environmentFile = config.sops.secrets."spend_tracker_env".path;
  };

  # Reverse proxy on a separate TLS port, reusing the Tailscale certificate.
  # App URL: https://nixos.taila654ac.ts.net:4539
  services.nginx.virtualHosts."spend-tracker" = {
    serverName = domain;
    addSSL = true;

    listen = [
      {
        addr = "0.0.0.0";
        port = spendTrackerPort;
        ssl = true;
      }
    ];

    sslCertificate = "/var/lib/tailscale/certs/${domain}.crt";
    sslCertificateKey = "/var/lib/tailscale/certs/${domain}.key";

    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString spendTrackerBackendPort}";
      recommendedProxySettings = true;
      # Photos are up to 10 MiB, sync pushes up to 5 MiB.
      extraConfig = "client_max_body_size 11m;";
    };
  };
}
