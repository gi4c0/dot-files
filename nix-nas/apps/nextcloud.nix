{ config, pkgs, ... }:

let
  domain = "nixos.taila654ac.ts.net";
  # Plain-HTTP port for LAN clients (e-ink readers) that can't reach the
  # Tailscale domain.
  nextcloudLanPort = 8087;
in
{
  # Enable Hardware Acceleration (Intel QuickSync)
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
    ];
  };

  # Nextcloud Setup
  services.nextcloud = {
    enable = true;
    hostName = domain;
    package = pkgs.nextcloud34;

    https = true;
    maxUploadSize = "16G";

    database.createLocally = true;
    configureRedis = true;

    settings = {
        default_phone_region = "PT";
        overwriteprotocol = "https";
    };

    config = {
      dbtype = "pgsql";
      adminuser = "admin";
      adminpassFile = config.sops.secrets.nextcloud_admin_pass.path;
    };

    extraAppsEnable = true;
    extraApps = with config.services.nextcloud.package.packages.apps; {
      inherit calendar contacts notes previewgenerator;
    };
  };

  # Database & Cache
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "nextcloud" ];
    ensureUsers = [
      {
        name = "nextcloud";
        ensureDBOwnership = true;
      }
    ];
  };

  services.redis.servers.nextcloud = {
    enable = true;
    port = 6379;
  };

  # Nginx Reverse Proxy using Tailscale Certs
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."${domain}" = {
      forceSSL = true;
      # Tailscale handles TLS certificates directly on your tailnet
      sslCertificate = "/var/lib/tailscale/certs/${domain}.crt";
      sslCertificateKey = "/var/lib/tailscale/certs/${domain}.key";
    };
  };

  # LAN WebDAV entry point: forwards to the HTTPS vhost above so Nextcloud
  # always sees its canonical domain.
  services.nginx.virtualHosts."nextcloud-lan" = {
    listen = [
      {
        addr = "0.0.0.0";
        port = nextcloudLanPort;
        ssl = false;
      }
    ];

    locations."/" = {
      proxyPass = "https://127.0.0.1:443";
      proxyWebsockets = true;
      # Must be off: the module appends the recommended-headers include
      # *after* extraConfig, whose `proxy_set_header Host $host` would
      # duplicate/override ours and make nginx upstream answer 400.
      recommendedProxySettings = false;
      extraConfig = ''
        proxy_set_header Host ${domain};
        proxy_set_header X-Forwarded-Proto https;
        proxy_set_header X-Forwarded-Host ${domain};
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_ssl_server_name on;
        proxy_ssl_name ${domain};
        client_max_body_size 16G;
      '';
    };
  };

  networking.firewall.allowedTCPPorts = [ nextcloudLanPort ];

  # Systemd service to auto-fetch & renew Tailscale TLS certificates
  systemd.services.tailscale-cert = {
    description = "Fetch Tailscale HTTPS Certificate";
    after = [ "tailscaled.service" ];
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.tailscale ];
    serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.writeShellScript "tailscale-cert-start" ''
        ${pkgs.tailscale}/bin/tailscale cert \
            --cert-file=/var/lib/tailscale/certs/${domain}.crt \
            --key-file=/var/lib/tailscale/certs/${domain}.key \
            "${domain}"
        
        chmod 755 /var/lib/tailscale /var/lib/tailscale/certs
        chmod 644 /var/lib/tailscale/certs/*
        ''}";
    };
  };

  # Ensure Nginx waits for the certificate service
  systemd.services.nginx.after = [ "tailscale-cert.service" ];
  systemd.services.nginx.wants = [ "tailscale-cert.service" ];
}
