{ config, pkgs, ... }:

let
  domain = "nixos.taila654ac.ts.net";
in
{
  sops = {
    defaultSopsFile = /home/nas/.dot-files/nix-nas/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    secrets.nextcloud_admin_pass = {
      owner = "nextcloud";
      group = "nextcloud";
    };
  };

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
