# Spend Tracker sync backend (Android expense app).
# Source: github.com/gi4c0/family_app, backend/ (module comes from its flake).
# Uses the local PostgreSQL (peer auth) and its own socket-only Redis.
# Public: https://spend.panchenkos.com through the Cloudflare Tunnel defined in
# photo-gallery.nix (cloudflared connects out, so no port is opened).
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  publicDomain = "spend.panchenkos.com";
  tunnelId = "5d607d03-d696-4a42-836b-44c82a5fc737";
  spendTrackerBackendPort = 4540;
  # Plain-HTTP nginx site for cloudflared, bound to loopback only.
  spendTrackerTunnelPort = 4544;
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

  services.cloudflared.tunnels.${tunnelId}.ingress.${publicDomain} =
    "http://127.0.0.1:${toString spendTrackerTunnelPort}";

  # Reached only through cloudflared; Cloudflare's edge handles TLS.
  services.nginx.virtualHosts."spend-tracker-public" = {
    serverName = publicDomain;
    listen = [
      {
        addr = "127.0.0.1";
        port = spendTrackerTunnelPort;
      }
    ];

    # cloudflared connects from loopback; take the visitor's address from the
    # header Cloudflare sets, so $remote_addr (and X-Real-IP) is the real client.
    # The backend rate-limits logins by X-Real-IP from loopback peers only.
    extraConfig = ''
      set_real_ip_from 127.0.0.1;
      set_real_ip_from ::1;
      real_ip_header CF-Connecting-IP;
    '';

    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString spendTrackerBackendPort}";
      recommendedProxySettings = true;
      # Photos are up to 10 MiB, sync pushes up to 5 MiB.
      extraConfig = "client_max_body_size 11m;";
    };
  };
}
