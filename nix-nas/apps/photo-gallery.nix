# Client photo gallery (photographer studio + private client links).
# Source: github.com/gi4c0/photo-gallery (module and packages come from its flake).
# nginx serves the React frontend and proxies /api to the Go backend, on two sites:
#   - tailnet: https://nixos.taila654ac.ts.net:4541 (Tailscale certificate)
#   - public:  https://kerrygallery.panchenkos.com through a Cloudflare Tunnel
#     (cloudflared connects out, so no port is opened on the router or firewall)
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  domain = "nixos.taila654ac.ts.net";
  photoGalleryPort = 4541;
  photoGalleryBackendPort = 4542;
  # Plain-HTTP nginx site for cloudflared, bound to loopback only.
  photoGalleryTunnelPort = 4543;
  publicDomain = "kerrygallery.panchenkos.com";
  tunnelId = "5d607d03-d696-4a42-836b-44c82a5fc737";
  frontend = inputs.photo-gallery.packages.${pkgs.stdenv.hostPlatform.system}.frontend;

  # Shared by both nginx sites.
  galleryLocations = {
    # Single-page app: unknown paths such as /g/<slug> load index.html.
    "/" = {
      tryFiles = "$uri /index.html";
      extraConfig = "add_header Cache-Control no-cache;";
    };

    # Vite puts a content hash in every asset name.
    "/assets/".extraConfig = ''
      add_header Cache-Control "public, max-age=31536000, immutable";
    '';

    # recommendedProxySettings sets X-Real-IP to $remote_addr, overwriting any
    # client value. The backend rate-limits by X-Real-IP for loopback peers.
    "/api/" = {
      proxyPass = "http://127.0.0.1:${toString photoGalleryBackendPort}";
      recommendedProxySettings = true;
      extraConfig = ''
        # Upload requests are capped at 4 GB by the backend; stream them through.
        client_max_body_size 4g;
        proxy_request_buffering off;
        # The "download all" ZIP is generated while it streams and can run for minutes.
        proxy_buffering off;
        proxy_read_timeout 1h;
        proxy_send_timeout 1h;
      '';
    };
  };
in
{
  services.photo-gallery = {
    enable = true;
    listenAddress = "127.0.0.1:${toString photoGalleryBackendPort}";
    photosDir = "/mnt/storage/photo-gallery/photos";
    dbPath = "/mnt/storage/photo-gallery/gallery.db";
  };

  # Reverse proxy on a separate TLS port, reusing the Tailscale certificate.
  # App URL: https://nixos.taila654ac.ts.net:4541
  # The first account registered there becomes the admin: register right after deploy.
  services.nginx.virtualHosts."photo-gallery" = {
    serverName = domain;
    addSSL = true;

    listen = [
      {
        addr = "0.0.0.0";
        port = photoGalleryPort;
        ssl = true;
      }
    ];

    sslCertificate = "/var/lib/tailscale/certs/${domain}.crt";
    sslCertificateKey = "/var/lib/tailscale/certs/${domain}.key";

    root = frontend;
    locations = galleryLocations;
  };

  # Cloudflare Tunnel credentials: the JSON from `cloudflared tunnel create`,
  # stored as a string in secrets.yaml.
  sops.secrets."cloudflared_nas" = { };

  services.cloudflared = {
    enable = true;
    tunnels.${tunnelId} = {
      credentialsFile = config.sops.secrets."cloudflared_nas".path;
      ingress.${publicDomain} = "http://127.0.0.1:${toString photoGalleryTunnelPort}";
      # Public hostnames: this gallery and spend-tracker.nix; any other gets 404.
      default = "http_status:404";
    };
  };

  # Public site: reached only through cloudflared. Cloudflare's edge handles
  # TLS, so this is plain HTTP bound to loopback.
  services.nginx.virtualHosts."photo-gallery-public" = {
    serverName = publicDomain;
    listen = [
      {
        addr = "127.0.0.1";
        port = photoGalleryTunnelPort;
      }
    ];

    root = frontend;
    locations = galleryLocations;

    # cloudflared connects from loopback; take the visitor's address from the
    # header Cloudflare sets, so $remote_addr (and X-Real-IP) is the real client.
    extraConfig = ''
      set_real_ip_from 127.0.0.1;
      set_real_ip_from ::1;
      real_ip_header CF-Connecting-IP;
    '';
  };
}
